part of 'post_reaction_bar_bloc.dart';

@freezed
sealed class PostReactionBarState with _$PostReactionBarState {
  const factory PostReactionBarState({
    // Dữ liệu cho nút Like
    @Default(0) int likeCount,
    @Default(false) bool isLiked,

    // Dữ liệu cho nút Save
    @Default(0) int saveCount,
    @Default(false) bool isSaved,
  }) = _PostReactionBarState;
}
