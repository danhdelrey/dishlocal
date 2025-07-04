import 'package:dishlocal/data/services/direction_service/exception/direction_service_exception.dart';

/// Interface định nghĩa các hoạt động liên quan đến việc lấy dữ liệu chỉ đường.
abstract class DirectionService {
  /// Lấy thông tin chỉ đường chi tiết giữa hai hoặc nhiều tọa độ.
  ///
  /// [coordinates] là một danh sách các cặp tọa độ `[kinh độ, vĩ độ]`.
  /// Ví dụ: `[[105.90, 9.78], [105.98, 9.77]]`.
  ///
  /// [profile] là phương thức di chuyển. Các giá trị phổ biến là:
  /// - `driving-traffic`: Lái xe (ô tô) có tính toán tình hình giao thông (mặc định).
  /// - `driving`: Lái xe không tính giao thông.
  /// - `walking`: Đi bộ.
  /// - `cycling`: Đi xe đạp.
  ///
  /// Ném ra các exceptions sau:
  /// - [NoRouteException]: Khi không tìm thấy tuyến đường nào giữa các tọa độ.
  /// - [NoSegmentException]: Khi một trong các tọa độ không nằm trên một đoạn đường có thể định tuyến.
  /// - [InvalidInputException]: Khi đầu vào (tọa độ, tham số) không hợp lệ.
  /// - [ProfileNotFoundException]: Khi profile di chuyển không được hỗ trợ.
  /// - [TooManyCoordinatesException]: Khi số lượng tọa độ vượt quá giới hạn cho phép.
  /// - [InvalidTokenException]: Khi access token không hợp lệ hoặc thiếu quyền.
  /// - [RateLimitExceededException]: Khi vượt quá giới hạn số lượng yêu cầu API.
  /// - [UnknownDirectionException]: Cho các lỗi không xác định khác từ server hoặc lỗi kết nối.
  Future<Map<String,dynamic>> getDirections({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  });

  /// Lấy thông tin chỉ đường đã được tối ưu hóa (tuyến đường ngắn nhất/nhanh nhất
  /// đi qua tất cả các điểm).
  ///
  /// Hữu ích cho các bài toán tối ưu lộ trình (ví dụ: giao hàng qua nhiều điểm).
  ///
  /// [coordinates] là một danh sách các cặp tọa độ `[kinh độ, vĩ độ]`.
  ///
  /// Ném ra các exceptions tương tự như `getDirections`:
  /// - [NoRouteException]
  /// - [NoSegmentException]
  /// - [InvalidInputException]
  /// - [ProfileNotFoundException]
  /// - [TooManyCoordinatesException]
  /// - [InvalidTokenException]
  /// - [RateLimitExceededException]
  /// - [UnknownDirectionException]
  Future<Map<String,dynamic>> getOptimizedRoute({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  });
}
