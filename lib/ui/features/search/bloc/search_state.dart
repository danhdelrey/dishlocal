part of 'search_bloc.dart';

enum SearchStatus {
  /// Trạng thái ban đầu, chưa tìm kiếm gì.
  initial,

  /// Đang thực hiện tìm kiếm ban đầu (trang đầu tiên của cả hai tab).
  loading,

  /// Tìm kiếm thành công, đã có kết quả.
  success,

  /// Tìm kiếm thất bại.
  failure,
}

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState({
    /// Query tìm kiếm hiện tại.
    required String query,

    /// Trạng thái chung của phiên tìm kiếm.
    required SearchStatus status,

    /// Thông báo lỗi chung nếu có.
    String? errorMessage,

    // --- State cho tab Bài viết (Posts) ---
    /// Danh sách các bài viết đã tải.
    @Default([]) List<Post> posts,

    /// Trang hiện tại của kết quả bài viết.
    @Default(0) int postPage,

    /// Còn trang bài viết tiếp theo để tải không?
    @Default(true) bool hasMorePosts,

    /// Đang tải trang bài viết tiếp theo?
    @Default(false) bool isLoadingMorePosts,

    // --- State cho tab Người dùng (Profiles) ---
    /// Danh sách các profile đã tải.
    @Default([]) List<AppUser> profiles,

    /// Trang hiện tại của kết quả profile.
    @Default(0) int profilePage,

    /// Còn trang profile tiếp theo để tải không?
    @Default(true) bool hasMoreProfiles,

    /// Đang tải trang profile tiếp theo?
    @Default(false) bool isLoadingMoreProfiles,
  }) = _SearchState;

  // Trạng thái khởi tạo ban đầu
  factory SearchState.initial() => const SearchState(
        query: '',
        status: SearchStatus.initial,
      );
}
