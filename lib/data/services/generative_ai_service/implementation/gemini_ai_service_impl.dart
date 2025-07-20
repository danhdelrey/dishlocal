import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/generative_ai_service/exception/generative_ai_service_exception.dart';
import 'package:dishlocal/data/services/generative_ai_service/interface/generative_ai_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Lớp triển khai của [GenerativeAiService] sử dụng Google Gemini API.
///
/// Lớp này chịu trách nhiệm:
/// 1. Tải ảnh từ một URL.
/// 2. Gửi ảnh và prompt đến Gemini Vision API.
/// 3. Phân tích cú pháp phản hồi để trích xuất mô tả món ăn.
/// 4. Xử lý các lỗi tiềm ẩn như lỗi mạng, lỗi API và lỗi đầu vào.
@LazySingleton(as: GenerativeAiService)
class GeminiAiServiceImpl implements GenerativeAiService {
  final Logger _log;
  final Dio _dio;
  final String _apiKey;

  // Sử dụng model gemini-1.5-flash vì nó nhanh và hiệu quả về chi phí cho các tác vụ vision.
  static const String _geminiModel = 'gemini-2.5-pro';
  static const String _geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/$_geminiModel:generateContent';

  // Cấu hình thời gian chờ để tránh treo ứng dụng khi mạng chậm hoặc API phản hồi lâu.
  static const Duration _apiTimeout = Duration(seconds: 45);

  GeminiAiServiceImpl()
      : _log = Logger('GeminiAiServiceImpl'),
        _dio = Dio(), // Khởi tạo một instance Dio mới
        _apiKey = AppEnvironment.geminiApiKey; // Lấy API key từ môi trường

  @override
  Future<String> generateDishDescription({
    required String imageUrl,
    required String dishName,
  }) async {
    _log.info('🚀 Bắt đầu tạo mô tả cho món: "$dishName"');

    // --- BƯỚC 1: Kiểm tra điều kiện tiên quyết ---
    if (_apiKey.isEmpty) {
      _log.severe('Lỗi nghiêm trọng: Gemini API Key chưa được cung cấp.');
      throw InvalidApiKeyException('API key is not configured.');
    }

    try {
      // --- BƯỚC 2: Chuẩn bị dữ liệu cho API call ---
      final imageBytes = await _downloadImageFromUrl(imageUrl);
      final base64Image = base64Encode(imageBytes);
      final requestBody = _buildApiRequestBody(dishName, base64Image);
      _log.fine('✅ Dữ liệu ảnh và request body đã được chuẩn bị.');

      // --- BƯỚC 3: Gọi Gemini API ---
      _log.fine('Đang gửi yêu cầu đến Gemini API...');
      final response = await _dio.post(
        _geminiApiUrl,
        queryParameters: {'key': _apiKey},
        data: requestBody,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          receiveTimeout: _apiTimeout,
          sendTimeout: _apiTimeout,
        ),
      );

      _log.info('✅ Nhận được phản hồi từ Gemini API (Status: ${response.statusCode})');

      // --- BƯỚC 4: Xử lý phản hồi và trả về kết quả ---
      final description = _parseDescriptionFromResponse(response.data);
      _log.info('🎉 Tạo mô tả thành công cho món "$dishName"!');

      return description;
    } on InvalidInputException {
      // Bắt và ném lại lỗi đầu vào đã được xử lý từ các hàm con
      rethrow;
    } on DioException catch (e, stackTrace) {
      // Xử lý tất cả các lỗi liên quan đến mạng và HTTP từ Dio
      _log.severe('Lỗi DioException khi giao tiếp với Gemini API.', e, stackTrace);
      throw _mapDioExceptionToServiceException(e);
    } on ContentGenerationException {
      // Bắt và ném lại lỗi tạo nội dung từ hàm parse
      rethrow;
    } catch (e, stackTrace) {
      // Bắt các lỗi không lường trước khác
      _log.severe('Đã xảy ra lỗi không xác định trong quá trình tạo mô tả.', e, stackTrace);
      throw UnknownGenerativeAiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Tải dữ liệu hình ảnh từ một URL.
  /// Ném ra [InvalidInputException] nếu URL không hợp lệ hoặc không thể tải được.
  Future<Uint8List> _downloadImageFromUrl(String imageUrl) async {
    try {
      _log.fine('Đang tải ảnh từ: $imageUrl');
      final response = await _dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes, receiveTimeout: const Duration(seconds: 20)),
      );

      if (response.data == null || response.data!.isEmpty) {
        throw InvalidInputException('Dữ liệu ảnh tải về bị rỗng.');
      }
      return Uint8List.fromList(response.data!);
    } on DioException catch (e) {
      _log.warning('Không thể tải ảnh từ URL.', e);
      throw InvalidInputException('Failed to download image from URL: $imageUrl. Error: ${e.message}');
    }
  }

  /// Xây dựng phần thân (body) của request để gửi đến Gemini API.
  Map<String, dynamic> _buildApiRequestBody(String dishName, String base64Image) {
    return {
      "contents": [
        {
          "parts": [
            {"text": "Hãy viết một đoạn mô tả ẩm thực ngắn gọn (5-10 câu), hấp dẫn về món ăn có tên \"$dishName\". Nếu hình ảnh là về món ăn đó thì dựa vào hình ảnh, hãy làm nổi bật vẻ ngoài, kết cấu có thể có, và gợi ý về hương vị để lôi cuốn người đọc. Nếu hình ảnh không liên quan đến món ăn có tên \"$dishName\" thì bỏ qua phần hình ảnh mà chỉ viết mô tả về món ăn \"$dishName\"."},
            {
              "inline_data": {"mime_type": "image/jpeg", "data": base64Image}
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.5, // Tăng nhẹ để có sự sáng tạo
        "maxOutputTokens": 1024,
      },
      "safetySettings": [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"}
      ]
    };
  }

  /// Trích xuất mô tả văn bản từ phản hồi JSON của API.
  /// Ném ra [ContentGenerationException] nếu không tìm thấy nội dung hợp lệ.
  String _parseDescriptionFromResponse(dynamic responseData) {
    try {
      // Cấu trúc phản hồi: response['candidates'][0]['content']['parts'][0]['text']
      final candidates = responseData['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) {
        final blockReason = responseData['promptFeedback']?['blockReason'];
        if (blockReason != null) {
          _log.warning('Nội dung bị chặn bởi bộ lọc an toàn. Lý do: $blockReason');
          throw ContentGenerationException('Content was blocked by safety filters. Reason: $blockReason');
        }
        throw ContentGenerationException('API response is missing "candidates" field.');
      }

      final text = candidates.first['content']['parts'][0]['text'] as String?;
      if (text == null || text.trim().isEmpty) {
        throw ContentGenerationException('API returned an empty description.');
      }
      return text.trim();
    } catch (e, stackTrace) {
      _log.severe('Không thể phân tích cú pháp phản hồi từ Gemini.', e, stackTrace);
      throw ContentGenerationException('Failed to parse a valid description from the API response.');
    }
  }

  /// Ánh xạ một [DioException] sang một [GenerativeAiServiceException] cụ thể hơn.
  GenerativeAiServiceException _mapDioExceptionToServiceException(DioException e) {
    // Lỗi có phản hồi từ server (lỗi HTTP 4xx, 5xx)
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final errorMessage = e.response!.data?['error']?['message'] ?? 'No specific error message from API.';
      _log.warning('Lỗi HTTP từ API - Status: $statusCode, Message: $errorMessage');

      switch (statusCode) {
        case 400:
          return InvalidInputException('Bad Request: $errorMessage. Please check the image format or prompt.');
        case 401:
        case 403:
          return InvalidApiKeyException('Authentication failed. The API Key may be invalid or missing permissions. ($errorMessage)');
        case 500:
        case 503:
          return GeminiServerException('Gemini API is currently unavailable (HTTP $statusCode). Please try again later.');
        default:
          return UnknownGenerativeAiException('Received an unexpected HTTP status code $statusCode from the API.');
      }
    } else {
      // Lỗi không có phản hồi từ server (lỗi mạng, timeout)
      _log.warning('Lỗi mạng hoặc kết nối. Type: ${e.type}');
      return GeminiNetworkException('Network error occurred. Please check your connection and try again. Error: ${e.message}');
    }
  }
}
