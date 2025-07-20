import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/generative_ai_service/exception/generative_ai_service_exception.dart';
import 'package:dishlocal/data/services/generative_ai_service/interface/generative_ai_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: GenerativeAiService)
class GeminiAiServiceImpl implements GenerativeAiService {
  final Logger _log;
  final Dio _dio;
  final String _apiKey;

  static const String _geminiModel = 'gemini-2.5-flash';
  static const String _geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/$_geminiModel:generateContent';
  static const Duration _apiTimeout = Duration(seconds: 60);

  GeminiAiServiceImpl()
      : _log = Logger('GeminiAiServiceImpl'),
        _dio = Dio(),
        _apiKey = AppEnvironment.geminiApiKey;

  @override
  Future<String> generateContent({
    required String prompt,
    String? imageUrl,
    Map<String, dynamic>? jsonSchema,
  }) async {
    _log.info('🚀 Bắt đầu yêu cầu tạo nội dung từ Generative AI Service.');
    if (jsonSchema != null) {
      _log.fine('Yêu cầu này sử dụng phương thức JSON Mode chính thức với responseSchema.');
    }

    if (_apiKey.isEmpty) {
      _log.severe('Lỗi: Gemini API Key chưa được cấu hình.');
      throw InvalidApiKeyException('API key is not configured.');
    }

    try {
      String? base64Image;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final imageBytes = await _downloadImageFromUrl(imageUrl);
        base64Image = base64Encode(imageBytes);
      }

      final requestBody = _buildApiRequestBody(
        prompt: prompt,
        base64Image: base64Image,
        schema: jsonSchema,
      );


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

      final generatedText = _parseContentFromResponse(response.data);
      _log.fine('Nội dung thô nhận được từ AI: $generatedText');

      _log.info('🎉 Service đã tạo nội dung thành công!');
      return generatedText;
    } on InvalidInputException {
      rethrow;
    } on DioException catch (e, stackTrace) {
      _log.severe('Lỗi DioException khi giao tiếp với Gemini API.', e, stackTrace);
      throw _mapDioExceptionToServiceException(e);
    } on ContentGenerationException {
      rethrow;
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định trong Generative AI Service.', e, stackTrace);
      throw UnknownGenerativeAiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  Map<String, dynamic> _buildApiRequestBody({
    required String prompt,
    String? base64Image,
    Map<String, dynamic>? schema,
  }) {
    final parts = <Map<String, dynamic>>[
      {'text': prompt}
    ];
    if (base64Image != null) {
      parts.add({
        'inline_data': {'mime_type': 'image/jpeg', 'data': base64Image}
      });
    }

    final Map<String, dynamic> generationConfig = {'temperature': 0.2, 'maxOutputTokens': 4096};

    if (schema != null) {
      generationConfig['responseMimeType'] = 'application/json';
      generationConfig['responseSchema'] = schema;
    }

    return {
      'contents': [
        {'parts': parts}
      ],
      'generationConfig': generationConfig,
      'safetySettings': [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"}
      ]
    };
  }

  String _parseContentFromResponse(dynamic responseData) {
    try {
      final candidates = responseData['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) {
        final blockReason = responseData['promptFeedback']?['blockReason'];
        if (blockReason != null) {
          throw ContentGenerationException('Content was blocked by safety filters. Reason: $blockReason');
        }
        throw ContentGenerationException('API response is missing "candidates" field.');
      }
      final text = candidates.first['content']['parts'][0]['text'] as String?;
      if (text == null || text.trim().isEmpty) {
        throw ContentGenerationException('API returned an empty content.');
      }
      return text.trim();
    } catch (e, stackTrace) {
      _log.severe('Không thể phân tích phản hồi từ Gemini.', e, stackTrace);
      throw ContentGenerationException('Failed to parse a valid content from the API response.');
    }
  }

  Future<Uint8List> _downloadImageFromUrl(String imageUrl) async {
    try {
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

  GenerativeAiServiceException _mapDioExceptionToServiceException(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final errorMessage = e.response!.data?['error']?['message'] ?? 'No specific error message from API.';
      switch (statusCode) {
        case 400:
          return InvalidInputException('Bad Request: $errorMessage.');
        case 401:
        case 403:
          return InvalidApiKeyException('Authentication failed: $errorMessage');
        case 500:
        case 503:
          return GeminiServerException('Gemini API is currently unavailable (HTTP $statusCode).');
        default:
          return UnknownGenerativeAiException('Received an unexpected HTTP status code $statusCode.');
      }
    } else {
      return GeminiNetworkException('Network error occurred. Please check your connection. Error: ${e.message}');
    }
  }
}
