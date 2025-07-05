import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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

  StreamSubscription<Either<DirectionFailure, LocationData>>? _locationSubscription;

  MapBloc(this._directionRepository) : super(const MapState.initial()) {
    on<_RouteRequested>(_onRouteRequested);
    on<_NavigationStarted>(_onNavigationStarted);
    on<_NavigationStopped>(_onNavigationStopped);
    on<_LocationUpdated>(_onLocationUpdated);
  }

  /// Xử lý sự kiện yêu cầu tải tuyến đường. (Không thay đổi)
  Future<void> _onRouteRequested(
    _RouteRequested event,
    Emitter<MapState> emit,
  ) async {
    emit(const MapState.loadInProgress());
    _log.info('Requesting route with ${event.coordinates.length} points...');

    final result = event.optimized
        ? await _directionRepository.getOptimizedRoute(
            coordinates: event.coordinates,
            profile: event.profile ?? 'driving-traffic',
          )
        : await _directionRepository.getDirections(
            coordinates: event.coordinates,
            profile: event.profile ?? 'driving-traffic',
          );

    result.fold(
      (failure) {
        _log.warning('Failed to get directions: $failure');
        emit(MapState.loadFailure(failure));
      },
      (direction) {
        _log.info('Successfully retrieved direction, emitting preview state.');
        emit(MapState.preview(direction));
      },
    );
  }

  /// Xử lý khi người dùng bắt đầu chế độ chỉ đường.
  void _onNavigationStarted(
    _NavigationStarted event,
    Emitter<MapState> emit,
  ) {
    // Sử dụng 'if (state is ...)' để kiểm tra kiểu của state hiện tại.
    final currentState = state;
    if (currentState is! Preview) {
      _log.warning('NavigationStarted called from a non-preview state.');
      return;
    }

    _log.info('Navigation started. Subscribing to location stream...');
    _locationSubscription?.cancel();

    _locationSubscription = _directionRepository.getLocationStream().listen((locationUpdate) => add(MapEvent.locationUpdated(locationUpdate)), onError: (error) {
      _log.severe('Error on location stream: $error');
      add(MapEvent.locationUpdated(left(const ServerOrNetworkFailure(message: 'Mất kết nối với dịch vụ vị trí.'))));
    });
  }

  /// Xử lý khi người dùng dừng chế độ chỉ đường.
  Future<void> _onNavigationStopped(
    _NavigationStopped event,
    Emitter<MapState> emit,
  ) async {
    final currentState = state;
    // Dùng 'if (state is ...)' để kiểm tra và truy cập dữ liệu.
    if (currentState is Navigating) {
      _log.info('Navigation stopped. Unsubscribing from location stream.');
      await _locationSubscription?.cancel();
      _locationSubscription = null;
      // Truy cập thuộc tính `direction` một cách an toàn
      // vì Dart đã tự động ép kiểu `currentState` thành `_Navigating`.
      emit(MapState.preview(currentState.direction));
    }
  }

  /// Xử lý khi có cập nhật vị trí mới (hoặc lỗi từ stream vị trí).
  void _onLocationUpdated(
    _LocationUpdated event,
    Emitter<MapState> emit,
  ) {
    // Lấy dữ liệu chỉ đường từ state hiện tại bằng cách kiểm tra kiểu.
    // Đây là cách thay thế cho `state.whenOrNull` bằng if/else.
    final currentState = state;
    Direction? direction;

    if (currentState is Preview) {
      // Nếu state là Preview, lấy direction từ nó.
      direction = currentState.direction;
    } else if (currentState is Navigating) {
      // Nếu state là Navigating, cũng lấy direction từ nó.
      direction = currentState.direction;
    }

    // Các trạng thái khác (_Initial, _LoadInProgress, _LoadFailure) không có
    // thuộc tính 'direction', nên biến `direction` sẽ vẫn là null.

    if (direction == null) {
      _log.warning('Received location update but no direction data is available.');
      return;
    }

    event.locationUpdate.fold(
      (failure) {
        _log.warning('Location stream failure: $failure');
      },
      (newLocation) {
        _log.finest('Location updated: ${newLocation.latitude}, ${newLocation.longitude}');
        emit(MapState.navigating(
          direction: direction!,
          currentLocation: newLocation,
        ));
      },
    );
  }

  /// Dọn dẹp subscription khi BLoC bị đóng. (Không thay đổi)
  @override
  Future<void> close() {
    _log.info('Closing MapBloc, canceling location subscription.');
    _locationSubscription?.cancel();
    return super.close();
  }
}
