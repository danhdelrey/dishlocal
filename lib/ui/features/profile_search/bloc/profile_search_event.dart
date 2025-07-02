part of 'profile_search_bloc.dart';

@freezed
class ProfileSearchEvent with _$ProfileSearchEvent {
  /// Bắt đầu một phiên tìm kiếm mới hoặc refresh.
  const factory ProfileSearchEvent.searchStarted(String query) = _SearchStarted;

  /// Yêu cầu tải trang tiếp theo.
  const factory ProfileSearchEvent.nextPageRequested() = _NextPageRequested;
}
