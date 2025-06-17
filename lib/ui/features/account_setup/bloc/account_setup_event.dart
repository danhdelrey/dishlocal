part of 'account_setup_bloc.dart';

sealed class AccountSetupEvent extends Equatable {
  const AccountSetupEvent();

  @override
  List<Object?> get props => [];
}

final class AccountSetupInitialized extends AccountSetupEvent {}

// Sự kiện khi người dùng thay đổi giá trị của trường username.
final class UsernameChanged extends AccountSetupEvent {
  const UsernameChanged({required this.username});
  final String username;

  @override
  List<Object?> get props => [username];
}

// Sự kiện khi người dùng thay đổi giá trị của trường tên hiển thị.
final class DisplayNameChanged extends AccountSetupEvent {
  const DisplayNameChanged({required this.displayName});
  final String displayName;

  @override
  List<Object?> get props => [displayName];
}

// Sự kiện khi người dùng thay đổi giá trị của trường tiểu sử.
final class BioChanged extends AccountSetupEvent {
  const BioChanged({required this.bio});
  final String bio;

  @override
  List<Object?> get props => [bio];
}

// Sự kiện khi người dùng nhấn nút submit form.
final class AccountSetupSubmitted extends AccountSetupEvent {}

// Sự kiện báo hiệu rằng yêu cầu focus đã được UI xử lý.
final class FocusRequestHandled extends AccountSetupEvent {}
