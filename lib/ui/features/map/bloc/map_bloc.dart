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

  /// Subscription để lắng nghe các cập nhật vị trí từ repository.
  /// Cần được hủy khi BLoC bị đóng để tránh rò rỉ bộ nhớ.
  StreamSubscription<Either<DirectionFailure, LocationData>>? _locationSubscription;

  /// Lưu trữ vị trí cuối cùng nhận được để sử dụng khi cần.
  LocationData? _currentLocation;

  MapBloc(this._directionRepository) : super(const MapState.initial()) {
    _log.info('MapBloc is being initialized.');

    // Đăng ký các trình xử lý sự kiện (event handlers)
    on<_RouteRequested>(_onRouteRequested);
    on<_NavigationStarted>(_onNavigationStarted);
    on<_LocationUpdated>(_onLocationUpdated);
    on<_LocationStreamFailed>(_onLocationStreamFailed);

    // Bắt đầu lắng nghe vị trí ngay lập tức
    _subscribeToLocationUpdates();
  }

  /// Đăng ký lắng nghe stream cập nhật vị trí.
  void _subscribeToLocationUpdates() {
    _log.info('Subscribing to location updates stream.');
    // Hủy subscription cũ nếu có để tránh đăng ký nhiều lần
    _locationSubscription?.cancel();
    _locationSubscription = _directionRepository.getLocationStream().listen(
      (failureOrLocation) {
        // Sử dụng fold để xử lý kết quả từ Either
        failureOrLocation.fold(
          (failure) {
            _log.warning('Received a failure from location stream: ${failure.message}');
            // Thêm sự kiện lỗi để BLoC xử lý
            add(MapEvent.locationStreamFailed(failure: failure));
          },
          (locationData) {
            // Thêm sự kiện cập nhật vị trí để BLoC xử lý
            add(MapEvent.locationUpdated(locationData: locationData));
          },
        );
      },
      onError: (error) {
        _log.severe('An unexpected error occurred in the location stream.', error);
        // Có thể thêm một sự kiện lỗi chung ở đây nếu cần
        add(const MapEvent.locationStreamFailed(failure: ServerOrNetworkFailure(message: 'Lỗi không xác định từ luồng vị trí.')));
      },
    );
  }

  /// Xử lý sự kiện yêu cầu tìm đường.
  Future<void> _onRouteRequested(_RouteRequested event, Emitter<MapState> emit) async {
    _log.info('Handling _RouteRequested event with ${event.coordinates.length} coordinates.');
    emit(const MapState.loadInProgress());

    final failureOrDirection = await _directionRepository.getDirections(
      coordinates: event.coordinates,
      profile: event.profile,
    );

    failureOrDirection.fold(
      (failure) {
        _log.warning('Failed to get directions: ${failure.runtimeType} - ${failure.message}');
        emit(MapState.loadFailure(failure: failure));
      },
      (direction) {
        _log.info('Successfully retrieved directions.');
        // Sử dụng vị trí cuối cùng đã được cập nhật từ stream
        emit(MapState.loadSuccess(direction: direction, currentLocation: _currentLocation));
      },
    );
  }

  /// Xử lý sự kiện cập nhật vị trí mới.
  void _onLocationUpdated(_LocationUpdated event, Emitter<MapState> emit) {
    _log.fine('Handling _LocationUpdated event: ${event.locationData}');
    // Cập nhật vị trí hiện tại
    _currentLocation = event.locationData;

    // Chỉ cập nhật state nếu đang ở trạng thái phù hợp (đã có route hoặc đang điều hướng)
    // `mapOrNull` đã được thay thế bằng các câu lệnh `if` để đảm bảo hoạt động
    // ngay cả khi file .freezed.dart chưa được cập nhật.

    final currentState = state; // Lấy state hiện tại ra một biến để dễ làm việc

    // Kiểm tra nếu state hiện tại là _LoadSuccess
    if (currentState is _LoadSuccess) {
      // emit một state mới bằng cách copy state cũ và cập nhật currentLocation
      emit(currentState.copyWith(currentLocation: event.locationData));
    }
    // Hoặc nếu state hiện tại là _Navigation
    else if (currentState is _Navigation) {
      // emit một state mới bằng cách copy state cũ và cập nhật currentLocation
      emit(currentState.copyWith(currentLocation: event.locationData));
    }
    
  }

  /// Xử lý sự kiện bắt đầu chế độ điều hướng.
  void _onNavigationStarted(_NavigationStarted event, Emitter<MapState> emit) {
    _log.info('Handling _NavigationStarted event.');

    // Chỉ có thể bắt đầu điều hướng khi đã tìm đường thành công
    final currentState = state;
    if (currentState is _LoadSuccess) {
      if (currentState.currentLocation != null) {
        _log.info('Switching to Navigation mode.');
        emit(MapState.navigation(
          direction: currentState.direction,
          currentLocation: currentState.currentLocation!,
        ));
      } else {
        // Trường hợp chưa có vị trí, có thể hiển thị lỗi hoặc chờ
        _log.warning('Cannot start navigation: current location is unknown.');
        // Tạm thời không thay đổi state, hoặc có thể emit một state lỗi cụ thể
        emit(const MapState.loadFailure(failure: InvalidRouteRequestFailure(message: "Không thể bắt đầu chỉ đường khi chưa xác định được vị trí của bạn.")));
      }
    } else {
      _log.shout('Invalid state transition: Cannot start navigation from state ${currentState.runtimeType}');
      // Đây là một lỗi logic, không nên xảy ra trong luồng hoạt động bình thường.
    }
  }

  /// Xử lý khi stream vị trí gặp lỗi.
  void _onLocationStreamFailed(_LocationStreamFailed event, Emitter<MapState> emit) {
    _log.severe('Handling _LocationStreamFailed: ${event.failure.message}');
    // Khi stream vị trí lỗi, ta coi đây là một lỗi nghiêm trọng và hiển thị thông báo.
    emit(MapState.loadFailure(failure: event.failure));
  }

  @override
  Future<void> close() {
    _log.info('MapBloc is closing. Cancelling location subscription.');
    // Rất quan trọng: Hủy subscription để tránh rò rỉ bộ nhớ.
    _locationSubscription?.cancel();
    return super.close();
  }
}
