import 'package:dishlocal/data/error/service_exception.dart';

//base class
sealed class GenerativeAiServiceException extends ServiceException {
  GenerativeAiServiceException(super.message);
}

/// Ném ra khi API key không hợp lệ, hết hạn hoặc bị từ chối.
class InvalidApiKeyException extends GenerativeAiServiceException {
  InvalidApiKeyException(String message) : super('Invalid API Key: $message');
}

/// Ném ra khi có lỗi về mạng (không có kết nối, timeout, DNS lookup failed).
class GeminiNetworkException extends GenerativeAiServiceException {
  GeminiNetworkException(String message) : super('Network Error: $message');
}

/// Ném ra khi đầu vào không hợp lệ (URL ảnh lỗi, định dạng không được hỗ trợ).
class InvalidInputException extends GenerativeAiServiceException {
  InvalidInputException(String message) : super('Invalid Input: $message');
}

/// Ném ra khi server của Gemini API gặp lỗi (lỗi 5xx).
class GeminiServerException extends GenerativeAiServiceException {
  GeminiServerException(String message) : super('Gemini Server Error: $message');
}

/// Ném ra khi API không thể tạo nội dung (ví dụ: bị bộ lọc an toàn chặn, hoặc không có kết quả trả về).
class ContentGenerationException extends GenerativeAiServiceException {
  ContentGenerationException(String message) : super('Content Generation Failed: $message');
}

/// Ném ra cho các trường hợp lỗi không xác định khác.
class UnknownGenerativeAiException extends GenerativeAiServiceException {
  UnknownGenerativeAiException(String message) : super('Unknown Error: $message');
}
