import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/generated_content/model/generated_content.dart';
import 'package:dishlocal/data/categories/generated_content/repository/failure/generated_content_failure.dart';
import 'package:dishlocal/data/categories/generated_content/repository/interface/generated_content_repository.dart';
import 'package:dishlocal/data/categories/generated_content/schemas/generated_content_schemas.dart';
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
  Future<Either<GeneratedContentFailure, GeneratedContent>> generateDishDescription({
    required String imageUrl,
    required String dishName,
  }) async {
    _log.info('Bắt đầu quy trình tạo mô tả cho món: "$dishName"');

    if (!_isDishNameValid(dishName)) {
      _log.warning('Tên món ăn "$dishName" không vượt qua kiểm tra sơ bộ.');
      return const Left(InvalidDishNameFailure());
    }

    try {
      // BƯỚC 1: XÁC THỰC SỰ KHỚP NHAU GIỮA ẢNH VÀ TÊN BẰNG SCHEMA
      _log.info('Bắt đầu bước xác thực bằng AI sử dụng JSON Schema.');
      final validationPrompt = "Dựa vào hình ảnh, hãy xác định xem nó có phải là món '$dishName' không. Trả lời theo định dạng JSON được yêu cầu.";
      final validationResponseString = await _generativeAiService.generateContent(
        prompt: validationPrompt,
        imageUrl: imageUrl,
        jsonSchema: GeneratedContentSchemas.validationSchema,
      );
      final Map<String, dynamic> validationResult = jsonDecode(validationResponseString);

      if (validationResult['isMatch'] != true) {
        final reason = validationResult['reason'] ?? 'không rõ lý do';
        _log.warning('Xác thực AI thất bại: Hình ảnh không khớp. Lý do: $reason');
        return const Left(MismatchedContentFailure());
      }
      _log.info('✅ Xác thực AI thành công. Hình ảnh và tên món ăn khớp nhau.');

      // BƯỚC 2: TẠO MÔ TẢ CHI TIẾT BẰNG SCHEMA
      _log.info('Bắt đầu bước tạo mô tả chi tiết sử dụng JSON Schema.');
      final descriptionPrompt = "Hãy viết một đoạn mô tả ẩm thực hấp dẫn về món ăn \"$dishName\", dựa trên hình ảnh đã được xác nhận là của món ăn này. Trả lời theo định dạng JSON được yêu cầu.";
      final descriptionResponseString = await _generativeAiService.generateContent(
        prompt: descriptionPrompt,
        imageUrl: imageUrl,
        jsonSchema: GeneratedContentSchemas.descriptionSchema,
      );
      final Map<String, dynamic> descriptionResult = jsonDecode(descriptionResponseString);
      final String description = descriptionResult['description']?.trim() ?? '';

      if (description.isEmpty) {
        _log.warning('AI đã trả về JSON nhưng không có nội dung mô tả.');
        return const Left(ContentGenerationFailure(message: 'AI không thể tạo mô tả cho món ăn này.'));
      }

      _log.info('🎉 Tạo mô tả thành công!');
      return Right(GeneratedContent(generatedContent: description));
    } on FormatException catch (e, stackTrace) {
      _log.severe('Lỗi giải mã JSON từ service. AI có thể đã không trả về JSON hợp lệ.', e, stackTrace);
      return const Left(UnknownFailure());
    } on GenerativeAiServiceException catch (e, stackTrace) {
      _log.severe('Một lỗi từ service đã xảy ra trong quá trình xử lý.', e, stackTrace);
      return Left(_mapServiceExceptionToFailure(e));
    } catch (e, stackTrace) {
      _log.severe('Một lỗi không xác định đã xảy ra ở tầng repository.', e, stackTrace);
      return const Left(UnknownFailure());
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
