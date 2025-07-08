part of 'post_bloc.dart';

// Enum để quản lý trạng thái tải dữ liệu một cách rõ ràng.
enum PostStatus { initial, loading, success, failure }

@freezed
sealed class PostState with _$PostState {
  const factory PostState({
    // Trạng thái hiện tại của việc tải dữ liệu.
    @Default(PostStatus.initial) PostStatus status,

    // Danh sách tất cả các bài viết đã được tải.
    @Default([]) List<Post> posts,

    // Cờ cho biết liệu còn trang để tải tiếp hay không.
    @Default(true) bool hasNextPage,

    // Trạng thái lọc và sắp xếp hiện tại.
    required FilterSortParams filterSortParams,

    // Lưu trữ lỗi nếu có.
    post_failure.PostFailure? failure,
  }) = _PostState;
}
