part of 'current_address_bloc.dart';

sealed class CurrentAddressEvent extends Equatable {
  const CurrentAddressEvent();

  @override
  List<Object> get props => [];
}

final class CurrentAddressRequested extends CurrentAddressEvent {}
