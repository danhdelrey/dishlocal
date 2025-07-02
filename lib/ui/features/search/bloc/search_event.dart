part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.initialized() = _Initialized;

  /// Được gọi khi người dùng nhập xong và nhấn enter.
  /// Bắt đầu một phiên tìm kiếm mới với query này.
  const factory SearchEvent.querySubmitted(String query) = _QuerySubmitted;

  /// Được gọi khi người dùng kéo xuống để tải thêm bài viết.
  const factory SearchEvent.nextPostPageRequested() = _NextPostPageRequested;

  /// Được gọi khi người dùng kéo xuống để tải thêm profile.
  const factory SearchEvent.nextProfilePageRequested() = _NextProfilePageRequested;

  /// Được gọi khi người dùng muốn refresh kết quả (kéo để làm mới).
  const factory SearchEvent.refreshed() = _Refreshed;
}
