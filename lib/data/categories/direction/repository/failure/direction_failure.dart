import 'package:dishlocal/data/error/repository_failure.dart';

/// Lớp cơ sở cho các lỗi liên quan đến việc lấy dữ liệu chỉ đường.
/// Các lỗi này được thiết kế để tầng UI có thể hiểu và hiển thị thông báo phù hợp.
sealed class DirectionFailure extends RepositoryFailure {
  const DirectionFailure(super.message);
}

// --- Các lớp Failure cụ thể ---

/// **Lỗi: Không tìm thấy đường đi.**
/// Dịch từ: [NoRouteException], [NoSegmentException].
/// Đây là lỗi phổ biến nhất mà người dùng có thể gặp. Thông điệp cần đơn giản, dễ hiểu.
final class RouteNotFoundFailure extends DirectionFailure {
  const RouteNotFoundFailure({
    String message = 'Không thể tìm thấy đường đi giữa các địa điểm bạn đã chọn. Vui lòng thử lại với các địa điểm khác.',
  }) : super(message);
}

/// **Lỗi: Dữ liệu đầu vào không hợp lệ.**
/// Dịch từ: [InvalidInputException], [TooManyCoordinatesException], [ProfileNotFoundException].
/// Lỗi này thường do logic trong ứng dụng gây ra, không phải do người dùng.
/// Thông điệp có thể chung chung để tránh làm người dùng bối rối.
final class InvalidRouteRequestFailure extends DirectionFailure {
  const InvalidRouteRequestFailure({
    String message = 'Yêu cầu tìm đường không hợp lệ. Vui lòng thử lại.',
  }) : super(message);
}

/// **Lỗi: Sự cố máy chủ hoặc kết nối.**
/// Dịch từ: [UnknownDirectionException], [RateLimitExceededException].
/// Bao gồm các lỗi mạng, lỗi server 5xx, hoặc các lỗi không xác định khác.
/// Đây là các lỗi tạm thời và người dùng nên được khuyến khích thử lại sau.
final class ServerOrNetworkFailure extends DirectionFailure {
  const ServerOrNetworkFailure({
    String message = 'Đã xảy ra sự cố kết nối. Vui lòng kiểm tra lại mạng và thử lại.',
  }) : super(message);
}

/// **Lỗi: Xác thực không thành công.**
/// Dịch từ: [InvalidTokenException].
/// Lỗi này rất hiếm khi xảy ra ở phía người dùng, thường là do cấu hình sai ở phía developer.
/// Thông điệp nên chung chung và nên có log chi tiết cho đội phát triển.
final class AuthenticationFailure extends DirectionFailure {
  const AuthenticationFailure({
    String message = 'Đã có lỗi xảy ra. Vui lòng khởi động lại ứng dụng.',
  }) : super(message);
}
