
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/direction/model/direction.dart';
import 'package:dishlocal/data/categories/direction/repository/failure/direction_failure.dart';

/// Interface (hợp đồng) cho repository quản lý dữ liệu chỉ đường.
/// Nó trừu tượng hóa nguồn dữ liệu và chỉ cung cấp các phương thức cần thiết
/// cho các use case (trường hợp sử dụng) của ứng dụng.
abstract class DirectionRepository {
  /// Lấy thông tin chỉ đường chi tiết giữa hai hoặc nhiều tọa độ.
  ///
  /// - [coordinates]: Danh sách các điểm `[kinh độ, vĩ độ]` để tìm đường đi.
  /// - [profile]: Phương thức di chuyển (ví dụ: 'driving-traffic', 'walking').
  ///
  /// Trả về một [Right] chứa đối tượng [Direction] khi thành công.
  /// Trả về một [Left] chứa một [DirectionFailure] cụ thể khi có lỗi, bao gồm:
  /// - [RouteNotFoundFailure]: Khi không tìm thấy đường đi giữa các địa điểm.
  /// - [InvalidRouteRequestFailure]: Khi yêu cầu không hợp lệ (sai tọa độ, quá nhiều điểm).
  /// - [ServerOrNetworkFailure]: Khi có lỗi máy chủ, mạng, hoặc vượt quá giới hạn yêu cầu.
  /// - [AuthenticationFailure]: Khi có lỗi xác thực (thường là do cấu hình sai).
  Future<Either<DirectionFailure, Direction>> getDirections({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  });

  /// Lấy thông tin chỉ đường đã được tối ưu hóa (tuyến đường nhanh nhất/ngắn nhất
  /// đi qua tất cả các điểm, không nhất thiết theo thứ tự ban đầu).
  ///
  /// - [coordinates]: Danh sách các điểm `[kinh độ, vĩ độ]` cần đi qua.
  /// - [profile]: Phương thức di chuyển.
  ///
  /// Trả về một [Right] chứa đối tượng [Direction] với lộ trình đã được sắp xếp lại tối ưu.
  /// Trả về một [Left] chứa các [DirectionFailure] tương tự như phương thức `getDirections`.
  Future<Either<DirectionFailure, Direction>> getOptimizedRoute({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  });
}
