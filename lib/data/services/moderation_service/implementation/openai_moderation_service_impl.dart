import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:dishlocal/data/services/moderation_service/model/openai/openai_moderation_models.dart';
import 'package:path/path.dart' as p;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationService)
class SightengineModerationServiceImpl implements ModerationService {
  final _log = Logger('SightengineModerationServiceImpl');

  final Dio _dio = Dio(BaseOptions(
    headers: {
      'Authorization': 'Bearer ${AppEnvironment.openAiApiKey}',
      'Content-Type': 'application/json',
    },
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));
  static const String _model = 'omni-moderation-latest';
  static const String _apiUrl = 'https://api.openai.com/v1/moderations';

  Future<String> _fileToBase64DataUrl(File file) async {
    _log.info('Bắt đầu chuyển đổi file thành Base64 Data URL cho: ${file.path}');
    try {
      final List<int> imageBytes = await file.readAsBytes();
      final String base64String = base64Encode(imageBytes);
      final String extension = p.extension(file.path).toLowerCase();
      String mimeType;
      switch (extension) {
        case '.jpg':
        case '.jpeg':
          mimeType = 'image/jpeg';
          break;
        case '.png':
          mimeType = 'image/png';
          break;
        case '.webp':
          mimeType = 'image/webp';
          break;
        default:
          _log.severe('Định dạng ảnh không được hỗ trợ: $extension');
          throw ArgumentError('Định dạng ảnh không được hỗ trợ: $extension');
      }
      final dataUrl = 'data:$mimeType;base64,$base64String';
      _log.info('Chuyển đổi file thành Base64 Data URL thành công.');
      _log.fine('Data URL (50 chars): ${dataUrl.substring(0, 50)}...');
      return dataUrl;
    } catch (e) {
      _log.severe('Lỗi trong quá trình chuyển đổi file thành Base64: $e');
      rethrow;
    }
  }

  @override
  Future<void> moderate({String? text, File? imageFile}) async {
    _log.info('Bắt đầu quy trình kiểm duyệt nội dung.');

    // Kiểm tra đầu vào hợp lệ, phải có ít nhất một trong hai
    if ((text == null || text.trim().isEmpty) && imageFile == null) {
      _log.warning('Hàm moderate được gọi mà không có text hoặc imageFile.');
      throw ModerationRequestException('Đầu vào không hợp lệ!');
    }

    final List<Map<String, dynamic>> inputs = [];

    // Thêm văn bản vào danh sách input nếu có
    if (text != null && text.trim().isNotEmpty) {
      _log.fine('Nội dung văn bản cần kiểm duyệt: "$text"');
      inputs.add({'type': 'text', 'text': text});
    }

    // Thêm ảnh vào danh sách input nếu có
    if (imageFile != null) {
      _log.info('Chuẩn bị kiểm duyệt ảnh: ${imageFile.path}');
      final String imageUrl = await _fileToBase64DataUrl(imageFile);
      inputs.add({
        'type': 'image_url',
        'image_url': {'url': imageUrl}
      });
    }

    // Gọi phương thức lõi để thực hiện yêu cầu
    await _performModeration(inputs);
  }

  Future<void> _performModeration(List<Map<String, dynamic>> inputs) async {
    final requestBody = {
      'model': _model,
      'input': inputs,
    };

    _log.info('Đang gửi yêu cầu kiểm duyệt đến OpenAI API...');
    _log.fine('Request Body:\n${const JsonEncoder.withIndent('  ').convert(requestBody)}');

    try {
      final response = await _dio.post(_apiUrl, data: requestBody);

      _log.info('Nhận được phản hồi từ API với mã trạng thái: ${response.statusCode}');
      _log.fine('Response Body:\n${const JsonEncoder.withIndent('  ').convert(response.data)}');

      final moderationResponse = ModerationResponse.fromJson(response.data);
      _processAndThrowIfFlagged(moderationResponse);

      _log.info('Kiểm duyệt hoàn tất: Nội dung an toàn.');
    } on DioException catch (e) {
      _log.severe('Lỗi DioException khi gọi API kiểm duyệt!', e, e.stackTrace);
      if (e.response != null) {
        _log.severe('Error Response Data:\n${const JsonEncoder.withIndent('  ').convert(e.response?.data)}');
      }
      final errorDetail = e.response?.data?['error']?['message'] ?? e.message;
      throw ModerationRequestException(errorDetail ?? 'Lỗi không xác định từ máy chủ');
    } on ArgumentError catch (e) {
      _log.severe('Lỗi ArgumentError trong quá trình kiểm duyệt!', e, e.stackTrace);
      throw ModerationRequestException(e.message);
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định trong _performModeration!', e, stackTrace);
      throw ModerationRequestException(e.toString());
    }
  }

  void _processAndThrowIfFlagged(ModerationResponse response) {
    _log.info('Đang xử lý kết quả kiểm duyệt...');

    if (response.results.isEmpty) {
      _log.warning('Phản hồi không chứa kết quả nào.');
      return;
    }

    final result = response.results.first;

    if (!result.flagged) {
      _log.info('Kết quả phân tích: Nội dung không bị gắn cờ (an toàn).');
      return;
    }

    _log.warning('NỘI DUNG BỊ GẮN CỜ! Phân tích chi tiết...');
    _log.fine('Chi tiết kết quả bị gắn cờ:\n${const JsonEncoder.withIndent('  ').convert(result.toJson())}');

    final categoriesMap = result.categories.toJson();
    final appliedTypesMap = result.categoryAppliedInputTypes.toJson();
    String? flaggedCategory;

    for (final entry in categoriesMap.entries) {
      if (entry.value == true) {
        flaggedCategory = entry.key;
        break;
      }
    }

    if (flaggedCategory != null) {
      _log.warning('Danh mục vi phạm chính: $flaggedCategory');
      final List<dynamic>? violatingInputs = appliedTypesMap[flaggedCategory];
      if (violatingInputs?.contains('text') ?? false) {
        _log.severe('Vi phạm được xác định trong VĂN BẢN. Ném TextUnsafeException.');
        throw TextUnsafeException(flaggedCategory);
      }
      if (violatingInputs?.contains('image') ?? false) {
        _log.severe('Vi phạm được xác định trong ẢNH. Ném ImageUnsafeException.');
        throw ImageUnsafeException(flaggedCategory);
      }
    }

    _log.severe('Nội dung bị gắn cờ nhưng không xác định được lý do cụ thể.');
    throw ModerationRequestException('Nội dung bị gắn cờ nhưng không xác định được lý do.');
  }
}
