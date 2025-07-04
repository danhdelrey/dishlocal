import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/services/direction_service/exception/direction_service_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/direction/model/direction.dart';
import 'package:dishlocal/data/categories/direction/repository/failure/direction_failure.dart';
import 'package:dishlocal/data/categories/direction/repository/interface/direction_repository.dart';
import 'package:dishlocal/data/services/direction_service/interface/direction_service.dart';

@LazySingleton(as: DirectionRepository)
class DirectionRepositoryImpl implements DirectionRepository {
  final _log = Logger('DirectionRepositoryImpl');
  final DirectionService _directionService;

  DirectionRepositoryImpl(this._directionService);

  /// Phương thức chung để gọi service, xử lý exception và parse dữ liệu.
  /// Giúp tránh lặp code trong các phương thức public.
  Future<Either<DirectionFailure, Direction>> _getRouteFromService(
    Future<Map<String, dynamic>> Function() serviceCall,
  ) async {
    try {
      _log.info('Đang gọi DirectionService để lấy dữ liệu thô...');
      final Map<String, dynamic> rawData = await serviceCall();
      _log.info('Lấy dữ liệu thô từ service thành công.');

      _log.info('Bắt đầu phân tích dữ liệu JSON thành model Direction...');
      final directionModel = Direction.fromJson(rawData);
      _log.fine('Phân tích dữ liệu thành công. Summary: ${directionModel.routes.first.toString()}');

      // Nếu mọi thứ thành công, trả về dữ liệu bên Right
      return Right(directionModel);
    }
    // Bắt các exception cụ thể từ service và dịch chúng sang Failure
    on NoRouteException catch (e, s) {
      _log.warning('Service không tìm thấy đường đi.', e, s);
      return const Left(RouteNotFoundFailure());
    } on NoSegmentException catch (e, s) {
      _log.warning('Service không thể khớp tọa độ với đoạn đường nào.', e, s);
      return const Left(RouteNotFoundFailure());
    } on InvalidInputException catch (e, s) {
      _log.severe('Yêu cầu gửi đến service không hợp lệ.', e, s);
      return const Left(InvalidRouteRequestFailure());
    } on TooManyCoordinatesException catch (e, s) {
      _log.warning('Số lượng tọa độ vượt quá giới hạn.', e, s);
      return const Left(InvalidRouteRequestFailure(message: 'Bạn đã chọn quá nhiều điểm, vui lòng giảm bớt.'));
    } on ProfileNotFoundException catch (e, s) {
      _log.severe('Profile di chuyển không được hỗ trợ.', e, s);
      return const Left(InvalidRouteRequestFailure());
    } on InvalidTokenException catch (e, s) {
      _log.severe('Lỗi xác thực với service. Access token có thể đã sai.', e, s);
      return const Left(AuthenticationFailure());
    } on RateLimitExceededException catch (e, s) {
      _log.warning('Vượt quá giới hạn yêu cầu API.', e, s);
      return const Left(ServerOrNetworkFailure(message: 'Bạn đã gửi quá nhiều yêu cầu, vui lòng thử lại sau giây lát.'));
    }
    // Bắt các lỗi chung từ service hoặc lỗi kết nối
    on DirectionServiceException catch (e, s) {
      _log.severe('Một lỗi chung từ DirectionService đã xảy ra.', e, s);
      return const Left(ServerOrNetworkFailure());
    }
    // Bắt các lỗi không mong muốn khác (ví dụ lỗi parsing JSON)
    catch (e, s) {
      _log.severe('Đã xảy ra lỗi không xác định trong repository.', e, s);
      return const Left(ServerOrNetworkFailure(message: 'Đã có lỗi xảy ra, vui lòng thử lại.'));
    }
  }

  @override
  Future<Either<DirectionFailure, Direction>> getDirections({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  }) {
    _log.info('Bắt đầu quy trình lấy chỉ đường thông thường cho ${coordinates.length} điểm.');
    // Gọi hàm helper và truyền vào hàm gọi service tương ứng
    return _getRouteFromService(
      () => _directionService.getDirections(
        coordinates: coordinates,
        profile: profile,
      ),
    );
  }

  @override
  Future<Either<DirectionFailure, Direction>> getOptimizedRoute({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  }) {
    _log.info('Bắt đầu quy trình lấy chỉ đường tối ưu cho ${coordinates.length} điểm.');
    // Gọi hàm helper và truyền vào hàm gọi service tương ứng
    return _getRouteFromService(
      () => _directionService.getOptimizedRoute(
        coordinates: coordinates,
        profile: profile,
      ),
    );
  }
}
