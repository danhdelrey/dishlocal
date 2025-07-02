import 'package:dishlocal/data/error/service_exception.dart';

/// Lớp cơ sở cho các lỗi liên quan đến SearchService.
sealed class SearchServiceException extends ServiceException {
  SearchServiceException(super.message);
}

//--- LỖI PHÍA CLIENT (TRƯỚC KHI GỌI API) ---

/// Bị throw khi truy vấn tìm kiếm không hợp lệ (ví dụ: query rỗng hoặc sai định dạng).
final class InvalidSearchQueryException extends SearchServiceException {
  InvalidSearchQueryException([String? message]) : super(message ?? 'Truy vấn tìm kiếm không hợp lệ.');
}

//--- LỖI KẾT NỐI ---

/// Bị throw khi có lỗi mạng hoặc không thể kết nối đến dịch vụ tìm kiếm (ví dụ: Algolia).
final class SearchConnectionException extends SearchServiceException {
  SearchConnectionException([String? message]) : super(message ?? 'Không thể kết nối đến dịch vụ tìm kiếm. Vui lòng kiểm tra kết nối mạng của bạn.');
}

//--- LỖI PHÍA SERVER (API) ---

/// Lớp cơ sở cho các lỗi cụ thể từ API tìm kiếm.
sealed class SearchApiException extends SearchServiceException {
  final int? statusCode;
  SearchApiException(super.message, [this.statusCode]);
}

/// Bị throw khi có lỗi xác thực (ví dụ: API Key sai hoặc thiếu quyền).
/// Thường tương ứng với HTTP 401/403.
final class SearchAuthenticationException extends SearchApiException {
  SearchAuthenticationException([String? message]) : super(message ?? 'Lỗi xác thực với dịch vụ tìm kiếm.', 403);
}

/// Bị throw khi vượt quá giới hạn truy vấn (rate-limited).
/// Thường tương ứng với HTTP 429.
final class SearchRateLimitException extends SearchApiException {
  SearchRateLimitException([String? message]) : super(message ?? 'Bạn đã tìm kiếm quá nhanh. Vui lòng thử lại sau giây lát.', 429);
}

/// Bị throw khi index tìm kiếm không tồn tại.
/// Thường tương ứng với HTTP 404.
final class SearchIndexNotFoundException extends SearchApiException {
  SearchIndexNotFoundException(String indexName, [String? message]) : super(message ?? 'Index "$indexName" không được tìm thấy.', 404);
}

/// Bị throw cho các lỗi không xác định khác từ server.
final class UnknownSearchApiException extends SearchApiException {
  UnknownSearchApiException({String? message, int? statusCode}) : super(message ?? 'Đã xảy ra lỗi không xác định từ dịch vụ tìm kiếm.', statusCode);
}

//--- LỖI PHÂN TÍCH DỮ LIỆU ---

/// Bị throw khi dữ liệu trả về từ dịch vụ tìm kiếm không hợp lệ hoặc không thể phân tích.
final class SearchDataParsingException extends SearchServiceException {
  final Object? originalError;
  SearchDataParsingException({String? message, this.originalError}) : super(message ?? 'Lỗi phân tích dữ liệu trả về từ dịch vụ tìm kiếm.');
}
