import 'package:dishlocal/data/error/service_exception.dart';

// Lớp cơ sở - bạn đã cung cấp
sealed class DirectionServiceException extends ServiceException {
  DirectionServiceException(super.message);

  /// Factory constructor để tạo ra exception cụ thể từ mã lỗi của Mapbox.
  /// `code` và `message` được lấy trực tiếp từ JSON response khi có lỗi.
  factory DirectionServiceException.fromResponse(String code, String message) {
    switch (code) {
      case 'NoRoute':
        return NoRouteException(message: 'Không tìm thấy tuyến đường phù hợp. $message');
      case 'NoSegment':
        return NoSegmentException(message: 'Một trong các toạ độ không nằm trên một đoạn đường có thể định tuyến. $message');
      case 'InvalidInput':
        return InvalidInputException(details: message);
      case 'ProfileNotFound':
        return ProfileNotFoundException(details: message);
      case 'TooManyCoordinates':
        return TooManyCoordinatesException();
      // Các mã lỗi khác có thể được thêm vào đây
      default:
        return UnknownDirectionException(details: 'Mã lỗi: $code, Chi tiết: $message');
    }
  }
}

// --- Các lớp Exception cụ thể ---

/// **Lỗi: NoRoute**
/// Được trả về khi không có tuyến đường nào được tìm thấy giữa các tọa độ được cung cấp.
/// Nguyên nhân: Các điểm nằm trên các đảo riêng biệt, trong khu vực cấm đi lại, hoặc
/// các điểm quá xa nhau (hơn 2000 km cho một số profile).
final class NoRouteException extends DirectionServiceException {
  NoRouteException({String message = 'Không tìm thấy tuyến đường phù hợp giữa các địa điểm.'}) : super(message);
}

/// **Lỗi: NoSegment**
/// Tương tự NoRoute, nhưng cụ thể hơn: một trong các tọa độ không thể khớp với bất kỳ
/// đoạn đường nào trong mạng lưới đường của Mapbox.
/// Nguyên nhân: Tọa độ nằm giữa biển, trong một toà nhà, hoặc ở một nơi không có dữ liệu đường.
final class NoSegmentException extends DirectionServiceException {
  NoSegmentException({String message = 'Điểm bắt đầu hoặc kết thúc không hợp lệ.'}) : super(message);
}

/// **Lỗi: InvalidInput**
/// Yêu cầu chứa dữ liệu đầu vào không hợp lệ.
/// Nguyên nhân: Sai định dạng tọa độ, giá trị tham số không hợp lệ, v.v.
/// `details` sẽ chứa thông báo lỗi cụ thể từ API.
final class InvalidInputException extends DirectionServiceException {
  final String details;
  InvalidInputException({required this.details}) : super('Yêu cầu không hợp lệ: $details');
}

/// **Lỗi: ProfileNotFound**
/// Profile di chuyển được yêu cầu (ví dụ: 'driving', 'walking') không tồn tại hoặc không được hỗ trợ.
/// Nguyên nhân: Gõ sai tên profile (ví dụ: 'drivin' thay vì 'driving').
final class ProfileNotFoundException extends DirectionServiceException {
  final String details;
  ProfileNotFoundException({required this.details}) : super('Phương thức di chuyển không được hỗ trợ: $details');
}

/// **Lỗi: TooManyCoordinates**
/// Số lượng tọa độ trong yêu cầu vượt quá giới hạn của API (thường là 25 cho profile driving).
final class TooManyCoordinatesException extends DirectionServiceException {
  TooManyCoordinatesException() : super('Số lượng tọa độ trong yêu cầu vượt quá giới hạn cho phép.');
}

/// **Lỗi: InvalidToken / Authentication**
/// Lỗi này thường được trả về qua HTTP status code 401 hoặc 403, không phải trong body JSON.
/// Bạn nên bắt lỗi này ở tầng gọi HTTP. Tuy nhiên, ta vẫn có thể định nghĩa nó ở đây để nhất quán.
final class InvalidTokenException extends DirectionServiceException {
  InvalidTokenException() : super('Mã truy cập (Access Token) không hợp lệ hoặc không có quyền truy cập.');
}

/// **Lỗi: RateLimitExceeded**
/// Lỗi này được trả về qua HTTP status code 429 khi bạn gửi quá nhiều yêu cầu.
/// Tương tự InvalidTokenException, nên được xử lý ở tầng HTTP.
final class RateLimitExceededException extends DirectionServiceException {
  RateLimitExceededException() : super('Vượt quá giới hạn số lượng yêu cầu. Vui lòng thử lại sau.');
}

/// **Lỗi không xác định**
/// Dùng cho các trường hợp lỗi không lường trước được từ server Mapbox hoặc các mã lỗi mới chưa được định nghĩa.
final class UnknownDirectionException extends DirectionServiceException {
  final String? details;
  UnknownDirectionException({this.details}) : super('Đã xảy ra lỗi không xác định từ dịch vụ chỉ đường${details != null ? ": $details" : "."}');
}
