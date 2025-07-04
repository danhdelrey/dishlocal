import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/direction/repository/interface/direction_repository.dart';
import 'package:dishlocal/data/categories/location/model/location_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';


part 'map_event.dart';
part 'map_state.dart';
part 'map_bloc.freezed.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final _log = Logger('MapBloc');
  final DirectionRepository _directionRepository;
  

  StreamSubscription<LocationData>? _locationSubscription;

  MapBloc(
    this._directionRepository,
    
  ) : super(const MapState.initial()) {
    on<_FindRouteRequested>(_onFindRouteRequested);
    on<_NavigationStarted>(_onNavigationStarted);
    on<_UserLocationUpdated>(_onUserLocationUpdated);
    on<_ArrivalConfirmed>(_onArrivalConfirmed);
    on<_Reset>(_onReset);
  }

  Future<void> _onFindRouteRequested(
    _FindRouteRequested event,
    Emitter<MapState> emit,
  ) async {
    _log.info('Bắt đầu tìm đường từ ${event.start} đến ${event.destination}');
    emit(const MapState.routeFinding());

    // Chuyển đổi LatLng sang format của repository
    final coordinates = [
      [event.start.longitude, event.start.latitude],
      [event.destination.longitude, event.destination.latitude],
    ];

    final result = await _directionRepository.getDirections(coordinates: coordinates);

    result.fold(
      (failure) {
        _log.warning('Tìm đường thất bại: ${failure.message}');
        emit(MapState.routeFindingFailure(failure));
      },
      (direction) {
        _log.info('Tìm đường thành công. Quãng đường: ${direction.routes.first.distance}m');
        emit(MapState.routeFound(direction: direction));
      },
    );
  }

  void _onNavigationStarted(
    _NavigationStarted event,
    Emitter<MapState> emit,
  ) {
    state.mapOrNull(
      routeFound: (routeFoundState) {
        _log.info('Bắt đầu chế độ chỉ đường.');
        _locationSubscription?.cancel(); // Hủy sub cũ nếu có

        // Bắt đầu lắng nghe vị trí của người dùng
        _locationSubscription = _locationService.getLocationStream().listen(
          (locationData) {
            // Đẩy event cập nhật vị trí vào BLoC
            add(MapEvent.userLocationUpdated(locationData));
          },
          onError: (error) {
            _log.severe('Lỗi từ stream vị trí: $error');
            // TODO: Xử lý lỗi khi không lấy được vị trí
          },
        );
      },
    );
  }

  Future<void> _onUserLocationUpdated(
    _UserLocationUpdated event,
    Emitter<MapState> emit,
  ) async {
    // Chỉ xử lý khi đang trong trạng thái đã tìm đường hoặc đang chỉ đường
    final currentDirection = state.mapOrNull(
      routeFound: (s) => s.direction,
      navigationInProgress: (s) => s.direction,
    );

    if (currentDirection == null) return;

    // Sử dụng helper để kiểm tra trạng thái
    final navStatus = _navigationHelper.update(
      userLocation: event.newLocation.toLatLng(), // Chuyển đổi sang LatLng
      route: currentDirection.routes.first,
    );

    if (navStatus.hasArrived) {
      _log.info('Người dùng đã đến đích!');
      await _cleanupNavigation();
      emit(const MapState.arrived());
    } else if (navStatus.isOffRoute) {
      _log.warning('Người dùng đi chệch khỏi tuyến đường. Bắt đầu tính toán lại.');
      emit(const MapState.rerouting());
      // Tự động tìm lại đường từ vị trí hiện tại đến đích cũ
      final destination = currentDirection.waypoints.last.location;
      add(MapEvent.findRouteRequested(
        start: event.newLocation.toLatLng(),
        destination: LatLng(destination[1], destination[0]),
      ));
    } else {
      // Vẫn đang trên đường, cập nhật UI
      emit(MapState.navigationInProgress(
        direction: currentDirection,
        userLocation: event.newLocation,
        currentStep: navStatus.currentStep!,
        distanceToNextManeuver: navStatus.distanceToNextManeuver!,
      ));
    }
  }

  void _onArrivalConfirmed(_ArrivalConfirmed event, Emitter<MapState> emit) {
    _log.info('Người dùng xác nhận đã đến nơi. Reset trạng thái.');
    emit(const MapState.initial());
  }

  Future<void> _onReset(_Reset event, Emitter<MapState> emit) async {
    await _cleanupNavigation();
    emit(const MapState.initial());
  }

  Future<void> _cleanupNavigation() async {
    _log.info('Dọn dẹp subscription vị trí.');
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  @override
  Future<void> close() {
    _cleanupNavigation();
    return super.close();
  }
}
