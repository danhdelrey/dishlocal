part of 'comment_bloc.dart';

@freezed
class CommentEvent with _$CommentEvent {
  const factory CommentEvent.initialized({
    required String postId,
    required int totalCommentCount,
  }) = _Initialized;

  const factory CommentEvent.moreCommentsRequested() = _MoreCommentsRequested;

  const factory CommentEvent.repliesRequested({
    required String parentCommentId,
  }) = _RepliesRequested;

  const factory CommentEvent.commentSubmitted({
    required String content,
  }) = _CommentSubmitted;

  const factory CommentEvent.replySubmitted({
    required String content,
  }) = _ReplySubmitted;

  const factory CommentEvent.replyTargetSet({
    required ReplyTarget target,
  }) = _ReplyTargetSet;

  const factory CommentEvent.replyTargetCleared() = _ReplyTargetCleared;

  const factory CommentEvent.commentLiked({
    required String commentId,
    required bool isLiked,
  }) = _CommentLiked;

  const factory CommentEvent.replyLiked({
    required String replyId,
    required String parentCommentId, // Cần để tìm trong state map
    required bool isLiked,
  }) = _ReplyLiked;

  const factory CommentEvent.commentDeleted({
    required String commentId,
  }) = _CommentDeleted;

  const factory CommentEvent.replyDeleted({
    required String replyId,
    required String parentCommentId,
  }) = _ReplyDeleted;

  /// Được gọi khi UI đã xử lý xong việc hiển thị lỗi.
  const factory CommentEvent.errorCleared() = _ErrorCleared;
}
