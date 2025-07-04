
import 'package:dishlocal/data/error/repository_failure.dart';

/// Lớp cơ sở cho các lỗi liên quan đến dịch vụ vị trí.
/// `sealed` đảm bảo tất cả các lớp con phải được định nghĩa trong cùng một file,
/// giúp cho việc xử lý tất cả các trường hợp lỗi trong UI bằng `switch` một cách an toàn.
sealed class LocationFailure extends RepositoryFailure {
  const LocationFailure(super.message);
}

/// Lỗi xảy ra khi người dùng đã tắt dịch vụ vị trí (GPS) trên thiết bị.
/// UI nên hướng dẫn người dùng bật nó lên.
class LocationServiceDisabledFailure extends LocationFailure {
  const LocationServiceDisabledFailure() : super('Dịch vụ vị trí trên thiết bị đã bị tắt. Vui lòng bật nó trong cài đặt.');
}

/// Lỗi xảy ra khi người dùng từ chối cấp quyền truy cập vị trí.
/// App có thể yêu cầu lại quyền này.
/// UI nên giải thích tại sao cần quyền và cung cấp nút để thử lại.
class LocationPermissionDeniedFailure extends LocationFailure {
  const LocationPermissionDeniedFailure() : super('Quyền truy cập vị trí đã bị từ chối. Tính năng này cần vị trí của bạn để hoạt động.');
}

/// Lỗi xảy ra khi người dùng đã từ chối vĩnh viễn quyền truy cập vị trí.
/// App không thể hiển thị lại hộp thoại yêu cầu quyền.
/// UI phải hướng dẫn người dùng vào cài đặt ứng dụng của hệ điều hành để cấp quyền thủ công.
class LocationPermissionPermanentlyDeniedFailure extends LocationFailure {
  const LocationPermissionPermanentlyDeniedFailure() : super('Quyền truy cập vị trí đã bị từ chối vĩnh viễn. Vui lòng vào cài đặt của ứng dụng để cấp quyền theo cách thủ công.');
}

/// Lỗi chung, không xác định được nguyên nhân cụ thể.
/// UI nên hiển thị một thông báo lỗi chung và gợi ý thử lại.
class LocationUnknownFailure extends LocationFailure {
  const LocationUnknownFailure() : super('Đã xảy ra lỗi không xác định khi lấy vị trí. Vui lòng thử lại.');
}
