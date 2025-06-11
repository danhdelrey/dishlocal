import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/data/categories/address/failure/address_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

part 'current_address_event.dart';
part 'current_address_state.dart';

class CurrentAddressBloc extends Bloc<CurrentAddressEvent, CurrentAddressState> {
  final _log = Logger('CurrentLocationBloc');
  final _addressRepository = getIt<AddressRepository>();

  CurrentAddressBloc() : super(CurrentAddressInitial()) {
    on<CurrentAddressRequested>((event, emit) async {
      _log.fine('CurrentAddressRequested event: Bắt đầu lấy địa chỉ hiện tại.');
      emit(CurrentAddressLoading());
      final result = await _addressRepository.getCurrentAddress();
      result.fold(
        (failure) {
          final state = switch (failure) {
            ServiceDisabledFailure() => LocationServiceDisabled(),
            PermissionDeniedFailure() => LocationPermissionDenied(),
            PermissionPermanentlyDeniedFailure() => LocationPermissionPermanentlyDenied(),
            UnknownFailure() => CurrentAddressFailure(failure.message),
          };
          _log.severe('CurrentAddressRequested event: Lấy địa chỉ hiện tại thất bại.');
          emit(state);
        },
        (address) {
          _log.fine('CurrentAddressRequested event: Lấy địa chỉ hiện tại thành công.');
          emit(CurrentAddressSuccess(address: address));
        },
      );
    });
  }
}
