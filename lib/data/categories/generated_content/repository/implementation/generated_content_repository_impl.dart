import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/generated_content/model/generated_content.dart';
import 'package:dishlocal/data/categories/generated_content/repository/failure/generated_content_failure.dart';
import 'package:dishlocal/data/categories/generated_content/repository/interface/generated_content_repository.dart';
import 'package:dishlocal/data/categories/generated_content/model/dish_details.dart';
import 'package:dishlocal/data/services/generative_ai_service/exception/generative_ai_service_exception.dart';
import 'package:dishlocal/data/services/generative_ai_service/interface/generative_ai_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: GeneratedContentRepository)
class GeneratedContentRepositoryImpl implements GeneratedContentRepository {
  final GenerativeAiService _generativeAiService;
  final _log = Logger('GeneratedContentRepositoryImpl');

  GeneratedContentRepositoryImpl(this._generativeAiService);

  @override
  Future<Either<GeneratedContentFailure, DishDetails>> generateDishDescription({
    required String imageUrl,
    required String dishName,
  }) async {
    _log.info('Bắt đầu quy trình tạo mô tả chi tiết cho món: "$dishName"');

    if (!_isDishNameValid(dishName)) {
      _log.warning('Tên món ăn "$dishName" không vượt qua kiểm tra sơ bộ.');
      return const Left(InvalidDishNameFailure());
    }

    try {
      // BƯỚC 1: XÁC THỰC
      final validationPrompt = "Dựa vào hình ảnh, hãy xác định xem nó có phải là món '$dishName' không.";
      final validationResponseString = await _generativeAiService.generateContent(prompt: validationPrompt, imageUrl: imageUrl, jsonSchema: DishDetails.validationSchema);
      final Map<String, dynamic> validationResult = jsonDecode(validationResponseString);

      if (validationResult['isMatch'] != true) {
        final reason = validationResult['reason'] ?? 'không rõ lý do';
        _log.warning('Xác thực AI thất bại. Lý do từ AI: $reason');
        return const Left(MismatchedContentFailure());
      }
      _log.info('✅ Xác thực AI thành công. Hình ảnh và tên món ăn khớp nhau.');

      // BƯỚC 2: TẠO MÔ TẢ CHI TIẾT
      _log.info('Bắt đầu bước tạo mô tả chi tiết sử dụng JSON Mode.');
      // Sử dụng prompt chi tiết do bạn cung cấp
      final descriptionPrompt = '''
      Viết một đoạn mô tả khách quan, rõ ràng tầm 10 câu về món ăn "$dishName".

      Ảnh đã được xác nhận chỉ dùng để nhận dạng món ăn, không phải cơ sở duy nhất để mô tả.

      Yêu cầu:
      - Mô tả tổng quan về món ăn dựa trên kiến thức ẩm thực phổ quát, không chỉ dựa vào một ảnh cụ thể.
      - Nêu rõ thành phần chính, cách chế biến phổ biến, nguồn gốc hoặc vùng miền liên quan.
      - Trình bày hương vị đặc trưng và mục đích sử dụng (ăn chính, ăn sáng, ăn vặt…).
      - Không dùng từ ngữ hoa mỹ hoặc cảm xúc chủ quan.
      - Không mô tả quá chi tiết hình ảnh cụ thể.
      - Văn phong khách quan, giống cách viết trong tài liệu hướng dẫn du lịch hoặc bách khoa ẩm thực.
      ''';

      final descriptionResponseString = await _generativeAiService.generateContent(prompt: descriptionPrompt, imageUrl: imageUrl, jsonSchema: DishDetails.detailedDescriptionSchema);
      _log.info('Đã nhận được phản hồi thô từ AI: $descriptionResponseString');

      // Giải mã JSON và tạo đối tượng DishDetails
      final Map<String, dynamic> descriptionJson = jsonDecode(descriptionResponseString);
      final dishDetails = DishDetails.fromJson(descriptionJson);

      _log.info('🎉 Tạo mô tả chi tiết thành công và đã được phân tích!');
      _log.fine('Mô tả chi tiết: ${dishDetails.toString()}');
      return Right(dishDetails);
    } on FormatException catch (e, stackTrace) {
      _log.severe('Lỗi giải mã JSON từ service. AI có thể đã không trả về JSON hợp lệ.', e, stackTrace);
      return const Left(UnknownFailure());
    } on GenerativeAiServiceException catch (e, stackTrace) {
      _log.severe('Một lỗi từ service đã xảy ra.', e, stackTrace);
      return Left(_mapServiceExceptionToFailure(e));
    } catch (e, stackTrace) {
      // Bắt lỗi từ DishDetails.fromJson (thiếu key, sai kiểu dữ liệu)
      _log.severe('Lỗi khi chuyển đổi JSON sang model DishDetails. Schema hoặc phản hồi từ AI không khớp.', e, stackTrace);
      return const Left(ContentGenerationFailure(message: 'Dữ liệu trả về từ AI không đúng định dạng mong muốn.'));
    }
  }

  bool _isDishNameValid(String dishName) {
    final trimmedName = dishName.trim();
    if (trimmedName.length < 3) return false;
    final invalidPattern = RegExp(r'^(.)\1+$|^[0-9\s]+$');
    return !invalidPattern.hasMatch(trimmedName);
  }

  GeneratedContentFailure _mapServiceExceptionToFailure(GenerativeAiServiceException e) {
    return switch (e) {
      GeminiNetworkException() => const NetworkFailure(),
      InvalidApiKeyException() => const ApiKeyFailure(),
      GeminiServerException() => const ServerFailure(),
      InvalidInputException() => const InvalidInputFailure(),
      ContentGenerationException() => ContentGenerationFailure(message: e.message),
      UnknownGenerativeAiException() => const UnknownFailure(),
    };
  }
}
