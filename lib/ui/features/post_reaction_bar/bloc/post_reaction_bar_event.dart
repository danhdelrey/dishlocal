part of 'post_reaction_bar_bloc.dart';

@freezed
class PostReactionBarEvent with _$PostReactionBarEvent {
  // Event được gửi khi người dùng nhấn nút Like/Unlike
  const factory PostReactionBarEvent.likeToggled() = _LikeToggled;

  // Event được gửi khi người dùng nhấn nút Save/Unsave
  const factory PostReactionBarEvent.saveToggled() = _SaveToggled;
}
