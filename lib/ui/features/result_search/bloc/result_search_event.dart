part of 'result_search_bloc.dart';

enum SearchType { posts, profiles }

@freezed
sealed class ResultSearchEvent with _$ResultSearchEvent {
  /// Bắt đầu một phiên tìm kiếm mới (chỉ gọi 1 lần khi màn hình mở ra)
  const factory ResultSearchEvent.searchStarted({required String query}) = _SearchStarted;

  /// Yêu cầu tải trang tiếp theo của kết quả hiện tại
  const factory ResultSearchEvent.nextPageRequested() = _NextPageRequested;

  /// Thay đổi loại tìm kiếm (chuyển tab)
  const factory ResultSearchEvent.searchTypeChanged({required SearchType searchType}) = _SearchTypeChanged;
}
