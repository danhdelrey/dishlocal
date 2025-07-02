part of 'post_search_bloc.dart';

@freezed
class PostSearchEvent with _$PostSearchEvent {
  /// Bắt đầu một phiên tìm kiếm mới hoặc refresh.
  const factory PostSearchEvent.searchStarted(String query) = _SearchStarted;

  /// Yêu cầu tải trang tiếp theo.
  const factory PostSearchEvent.nextPageRequested() = _NextPageRequested;
}
