import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/location/model/location_data.dart';
import 'package:dishlocal/data/categories/location/repository/failure/location_failure.dart';

abstract class LocationRepository {
  /// Lắng nghe các cập nhật vị trí theo thời gian thực.
  ///
  /// Trả về một Stream của `Either`:
  /// - `Right(LocationData)`: Khi nhận được một vị trí mới thành công.
  /// - `Left(LocationFailure)`: Khi có lỗi xảy ra trong quá trình lấy vị trí
  ///   (ví dụ: dịch vụ bị tắt, người dùng từ chối quyền, v.v.).
  ///
  /// Stream sẽ phát ra một lỗi (Left) và có thể kết thúc nếu lỗi đó là không thể phục hồi
  /// (ví dụ: quyền bị từ chối vĩnh viễn).
  Stream<Either<LocationFailure, LocationData>> getLocationStream();
}
