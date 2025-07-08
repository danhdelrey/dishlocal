part of 'post_bloc.dart';

@freezed
sealed class PostEvent with _$PostEvent {
  /// Yêu cầu tải trang dữ liệu tiếp theo.
  const factory PostEvent.fetchNextPageRequested() = _FetchNextPageRequested;

  /// Yêu cầu làm mới (tải lại từ đầu).
  const factory PostEvent.refreshRequested() = _RefreshRequested;

  /// Được gọi khi người dùng thay đổi bộ lọc hoặc sắp xếp.
  const factory PostEvent.filtersChanged({required FilterSortParams newFilters}) = _FiltersChanged;
}
