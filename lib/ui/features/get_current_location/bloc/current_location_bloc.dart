import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  // 1. Khởi tạo Logger
  final _log = Logger('CurrentLocationBloc');

  CurrentLocationBloc() : super(CurrentLocationInitial()) {
    on<CurrentLocationRequested>(_onCurrentLocationRequested);
  }

  Future<void> _onCurrentLocationRequested(
    CurrentLocationRequested event,
    Emitter<CurrentLocationState> emit,
  ) async {
    _log.info('Event CurrentLocationRequested: Bắt đầu lấy vị trí hiện tại...');

    // 2. Emit trạng thái Loading ngay lập tức
    emit(CurrentLocationLoading());

    try {
      // BƯỚC 1: KIỂM TRA DỊCH VỤ VỊ TRÍ
      _log.fine('Đang kiểm tra dịch vụ vị trí (isLocationServiceEnabled)...');
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _log.warning('Dịch vụ vị trí đã bị tắt.');
        // Emit state cụ thể thay vì ném lỗi
        emit(LocationServiceDisabled());
        return; // Dừng xử lý
      }
      _log.info('Dịch vụ vị trí đã được bật.');

      // BƯỚC 2: KIỂM TRA VÀ YÊU CẦU QUYỀN
      _log.fine('Đang kiểm tra quyền vị trí (checkPermission)...');
      var permission = await Geolocator.checkPermission();
      _log.info('Trạng thái quyền ban đầu: ${permission.name}');

      if (permission == LocationPermission.denied) {
        _log.info('Quyền bị từ chối, đang yêu cầu lại (requestPermission)...');
        permission = await Geolocator.requestPermission();
        _log.info('Kết quả yêu cầu quyền lại: ${permission.name}');

        if (permission == LocationPermission.denied) {
          _log.warning('Người dùng đã từ chối cấp quyền.');
          // Emit state cụ thể để UI có thể hiển thị giải thích
          emit(LocationPermissionDenied());
          return; // Dừng xử lý
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _log.severe('Quyền vị trí đã bị từ chối vĩnh viễn.');
        // Emit state cụ thể để UI hướng dẫn người dùng mở cài đặt
        emit(LocationPermissionPermanentlyDenied());
        return; // Dừng xử lý
      }
      _log.info('Quyền vị trí đã được cấp.');

      // BƯỚC 3: LẤY VỊ TRÍ HIỆN TẠI
      // Khi đến được đây, chúng ta chắc chắn đã có quyền
      _log.fine('Đang lấy vị trí hiện tại (getCurrentPosition)...');
      final position = await Geolocator.getCurrentPosition();
      _log.info('Lấy vị trí thành công: Lat ${position.latitude}, Lon ${position.longitude}');

      // 4. Emit trạng thái thành công
      emit(CurrentLocationSuccess(position: position));
    } catch (e, stackTrace) {
      // 5. Bắt các lỗi không lường trước được
      _log.severe('Lỗi không xác định khi lấy vị trí: $e', e, stackTrace);
      emit(CurrentLocationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }
}
