import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/failure/address_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'current_address_event.dart';
part 'current_address_state.dart';

//BLoC thường được tạo mới mỗi khi cần, nên chúng ta dùng @injectable hoặc @factory.
// `@injectable` tương đương với `@factory` theo mặc định
@injectable
class CurrentAddressBloc extends Bloc<CurrentAddressEvent, CurrentAddressState> {
  // Sửa tên Logger cho nhất quán
  final _log = Logger('CurrentAddressBloc');

  // 1. Nhận Repository qua constructor (Dependency Injection)
  final AddressRepository _addressRepository;

  // Constructor yêu cầu một AddressRepository
  CurrentAddressBloc({required AddressRepository addressRepository})
      : _addressRepository = addressRepository,
        super(CurrentAddressInitial()) {
    on<CurrentAddressRequested>(_onCurrentAddressRequested);
  }

  // Tách logic xử lý event ra một phương thức riêng cho gọn gàng
  Future<void> _onCurrentAddressRequested(
    CurrentAddressRequested event,
    Emitter<CurrentAddressState> emit,
  ) async {
    _log.fine('Event: Bắt đầu lấy địa chỉ hiện tại.');
    emit(CurrentAddressLoading());

    final result = await _addressRepository.getCurrentAddress();

    result.fold(
      (failure) {
        _log.warning('Lấy địa chỉ thất bại. Failure: ${failure.runtimeType}');
        // Chuyển đổi Failure thành State tương ứng
        emit(_mapFailureToState(failure));
      },
      (address) {
        _log.info('Lấy địa chỉ thành công: ${address.address}');
        emit(CurrentAddressSuccess(address: address));
      },
    );
  }

  // 2. Phương thức helper để ánh xạ Failure sang State
  // Giúp logic trong `fold` gọn hơn và có thể tái sử dụng
  CurrentAddressState _mapFailureToState(AddressFailure failure) {
    // Dùng switch expression để trả về State một cách trực tiếp
    return switch (failure) {
      ServiceDisabledFailure() => LocationServiceDisabled(),
      PermissionDeniedFailure() => LocationPermissionDenied(),
      PermissionPermanentlyDeniedFailure() => LocationPermissionPermanentlyDenied(),
      // Xử lý các lỗi khác, ví dụ GeocodingFailure
      GeocodingFailure() => CurrentAddressFailure(failure.message),
      UnknownFailure() => const CurrentAddressFailure("An unknown error occurred."),
    };
  }
}
