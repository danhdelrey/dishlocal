part of 'comment_bloc.dart';

enum CommentStatus { initial, loading, success, failure }

/// Một đối tượng nhỏ để giữ thông tin về người đang được trả lời.
@freezed
sealed class ReplyTarget with _$ReplyTarget {
  const factory ReplyTarget({
    /// ID của bình luận gốc mà trả lời này thuộc về.
    required String parentCommentId,

    /// ID của người dùng được trả lời.
    required String replyToUserId,

    /// Username của người dùng được trả lời (để hiển thị @username).
    required String replyToUsername,
  }) = _ReplyTarget;
}

@freezed
sealed class CommentState with _$CommentState {
  const factory CommentState({
    // --- Trạng thái chung ---
    required String postId,
    required CommentStatus status,
    CommentFailure? failure,

    // --- Bình luận gốc ---
    required List<Comment> comments,
    required bool hasMoreComments,
    required int totalCommentCount,

    // --- Trả lời ---
    /// Map: parentCommentId -> List<CommentReply>
    required Map<String, List<CommentReply>> replies,

    /// Map: parentCommentId -> bool (còn trả lời để tải không?)
    required Map<String, bool> hasMoreReplies,

    /// Map: parentCommentId -> Trạng thái tải của các trả lời
    required Map<String, CommentStatus> replyLoadStatus,

    // --- Trạng thái tương tác ---
    /// Lưu thông tin khi người dùng nhấn nút "Trả lời".
    ReplyTarget? replyTarget,
  }) = _CommentState;

  factory CommentState.initial() => const CommentState(
        postId: '',
        status: CommentStatus.initial,
        failure: null,
        comments: [],
        hasMoreComments: true,
        totalCommentCount: 0,
        replies: {},
        hasMoreReplies: {},
        replyLoadStatus: {},
        replyTarget: null,
      );
}
