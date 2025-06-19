import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_reaction_bar_event.dart';
part 'post_reaction_bar_state.dart';
part 'post_reaction_bar_bloc.freezed.dart';

class PostReactionBarBloc extends Bloc<PostReactionBarEvent, PostReactionBarState> {
  PostReactionBarBloc()
      : super(
            // Khởi tạo state ban đầu với một số dữ liệu giả
            const PostReactionBarState(
          likeCount: 135,
          isLiked: false,
          saveCount: 42,
          isSaved: true, // Giả sử bài viết này đã được lưu từ trước
        )) {
    // Đăng ký các handler cho từng event
    on<_LikeToggled>(_onLikeToggled);
    on<_SaveToggled>(_onSaveToggled);
  }

  // Xử lý khi người dùng nhấn nút Like/Unlike
  void _onLikeToggled(_LikeToggled event, Emitter<PostReactionBarState> emit) {
    // Lấy trạng thái hiện tại
    final newIsLiked = !state.isLiked;
    final newLikeCount = newIsLiked ? state.likeCount + 1 : state.likeCount - 1;

    // Phát ra một state mới với dữ liệu đã được cập nhật
    emit(state.copyWith(
      isLiked: newIsLiked,
      likeCount: newLikeCount,
    ));
  }

  // Xử lý khi người dùng nhấn nút Save/Unsave
  void _onSaveToggled(_SaveToggled event, Emitter<PostReactionBarState> emit) {
    // Lấy trạng thái hiện tại
    final newIsSaved = !state.isSaved;
    final newSaveCount = newIsSaved ? state.saveCount + 1 : state.saveCount - 1;

    // Phát ra một state mới
    emit(state.copyWith(
      isSaved: newIsSaved,
      saveCount: newSaveCount,
    ));
  }
}
