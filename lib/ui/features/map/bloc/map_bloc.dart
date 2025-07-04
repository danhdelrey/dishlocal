import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/direction/model/direction.dart';
import 'package:dishlocal/data/categories/direction/model/location_data.dart';
import 'package:dishlocal/data/categories/direction/repository/failure/direction_failure.dart';
import 'package:dishlocal/data/categories/direction/repository/interface/direction_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'map_event.dart';
part 'map_state.dart';
part 'map_bloc.freezed.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final _log = Logger('MapBloc');
  final DirectionRepository _directionRepository;

  // Subscription để lắng nghe stream vị trí, cần được quản lý (hủy) cẩn thận
  StreamSubscription? _locationSubscription;
  // Lưu lại tọa độ đích để sử dụng cho mỗi lần cập nhật vị trí
  List<double>? _destinationCoordinates;

  MapBloc(this._directionRepository) : super(const MapState.initial()) {
    // Đăng ký các handler cho từng event
    on<_NavigationStarted>(_onNavigationStarted);
    on<_LocationUpdated>(_onLocationUpdated);
    on<_LocationStreamFailed>(_onLocationStreamFailed);
  }

  /// Xử lý khi UI yêu cầu bắt đầu chỉ đường
  void _onNavigationStarted(_NavigationStarted event, Emitter<MapState> emit) {
    _log.info('Bắt đầu quy trình chỉ đường tới: ${event.destinationCoordinates}');
    emit(const MapState.loading());

    // Lưu lại tọa độ đích
    _destinationCoordinates = event.destinationCoordinates;

    // Hủy subscription cũ nếu có để tránh nhiều stream chạy song song
    _locationSubscription?.cancel();

    // Bắt đầu lắng nghe stream vị trí từ repository
    _locationSubscription = _directionRepository.getLocationStream().listen((result) {
      // result là Either<DirectionFailure, LocationData>
      result.fold(
        (failure) {
          // Nếu stream trả về lỗi, thêm event báo lỗi
          _log.warning('Stream vị trí báo lỗi: ${failure.toString()}');
          add(MapEvent.locationStreamFailed(failure: failure));
        },
        (locationData) {
          // Nếu stream trả về vị trí mới, thêm event cập nhật
          _log.fine('Stream nhận được vị trí mới: ${locationData.latitude}, ${locationData.longitude}');
          add(MapEvent.locationUpdated(userLocation: locationData));
        },
      );
    }, onError: (error) {
      // Xử lý các lỗi không mong muốn từ chính bản thân stream
      _log.severe('Lỗi không xác định từ stream vị trí', error);
      add(const MapEvent.locationStreamFailed(failure: ServerOrNetworkFailure(message: 'Lỗi không xác định từ stream vị trí')));
    });
  }

  /// Xử lý khi có vị trí mới từ stream
  Future<void> _onLocationUpdated(_LocationUpdated event, Emitter<MapState> emit) async {
    if (_destinationCoordinates == null) {
      _log.severe('Không thể lấy chỉ đường vì tọa độ đích là null.');
      emit(const MapState.failure(failure: InvalidRouteRequestFailure(message: 'Tọa độ đích chưa được thiết lập.')));
      return;
    }

    _log.info('Đang tính toán lại đường đi từ vị trí mới...');

    final userCoords = [event.userLocation.longitude, event.userLocation.latitude];
    final coordinates = [userCoords, _destinationCoordinates!];

    // Gọi repository để lấy chỉ đường
    final result = await _directionRepository.getDirections(coordinates: coordinates);

    result.fold(
      (failure) {
        _log.warning('Không thể lấy chỉ đường: ${failure.toString()}');
        emit(MapState.failure(failure: failure));
      },
      (direction) {
        _log.fine('Cập nhật chỉ đường thành công.');
        // Phát ra trạng thái thành công với dữ liệu mới
        emit(MapState.success(
          direction: direction,
          userLocation: event.userLocation, // Gửi cả vị trí user để UI cập nhật marker
        ));
      },
    );
  }

  /// Xử lý khi stream vị trí báo lỗi
  void _onLocationStreamFailed(_LocationStreamFailed event, Emitter<MapState> emit) {
    emit(MapState.failure(failure: event.failure));
    // Khi có lỗi (ví dụ: mất quyền vĩnh viễn), dừng việc lắng nghe
    _locationSubscription?.cancel();
  }

  // Rất quan trọng: Hủy subscription khi BLoC bị đóng
  @override
  Future<void> close() {
    _log.info('MapBloc được đóng, hủy location subscription.');
    _locationSubscription?.cancel();
    return super.close();
  }
}
