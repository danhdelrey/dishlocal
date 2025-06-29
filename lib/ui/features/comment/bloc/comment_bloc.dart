// file: lib/application/comment/comment_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/data/categories/comment/repository/failure/comment_failure.dart';
import 'package:dishlocal/data/categories/comment/repository/interface/comment_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

part 'comment_event.dart';
part 'comment_state.dart';
part 'comment_bloc.freezed.dart';

const int _kCommentPageLimit = 10;
const int _kReplyPageLimit = 10;

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _log = Logger('CommentBloc');
  final AppUserRepository _appUserRepository;
  final CommentRepository _commentRepository;
  final Uuid _uuid = const Uuid();

  CommentBloc(this._appUserRepository, this._commentRepository) : super(CommentState.initial()) {
    on<_Initialized>(_onInitialized);
    on<_MoreCommentsRequested>(_onMoreCommentsRequested);
    on<_RepliesRequested>(_onRepliesRequested);
    on<_CommentSubmitted>(_onCommentSubmitted);
    on<_ReplySubmitted>(_onReplySubmitted);
    on<_ReplyTargetSet>((event, emit) => emit(state.copyWith(replyTarget: event.target)));
    on<_ReplyTargetCleared>((event, emit) => emit(state.copyWith(replyTarget: null)));
    on<_CommentLiked>(_onCommentLiked);
    on<_ReplyLiked>(_onReplyLiked);
    // Các event xóa có thể được thêm vào tương tự
  }

  Future<void> _onInitialized(_Initialized event, Emitter<CommentState> emit) async {
    _log.info('▶️ Initializing CommentBloc for postId: ${event.postId} with total count: ${event.totalCommentCount}');
    emit(state.copyWith(
      postId: event.postId,
      totalCommentCount: event.totalCommentCount,
      status: CommentStatus.loading,
    ));

    final result = await _commentRepository.getCommentsForPost(
      postId: event.postId,
      limit: _kCommentPageLimit,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to initialize comments: $failure');
        emit(state.copyWith(status: CommentStatus.failure, failure: failure));
      },
      (comments) {
        _log.info('✅ Initialized with ${comments.length} comments.');
        emit(state.copyWith(
          status: CommentStatus.success,
          comments: comments,
          hasMoreComments: comments.length < event.totalCommentCount,
        ));
      },
    );
  }

  Future<void> _onMoreCommentsRequested(_MoreCommentsRequested event, Emitter<CommentState> emit) async {
    if (!state.hasMoreComments) {
      _log.warning('⚠️ No more comments to load, request ignored.');
      return;
    }
    _log.info('⏬ Requesting more comments...');
    emit(state.copyWith(status: CommentStatus.loading)); // Thể hiện trạng thái tải chung

    final result = await _commentRepository.getCommentsForPost(
      postId: state.postId,
      limit: _kCommentPageLimit,
      startAfter: state.comments.last.createdAt,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to load more comments: $failure');
        emit(state.copyWith(status: CommentStatus.failure, failure: failure));
      },
      (newComments) {
        _log.info('✅ Loaded ${newComments.length} more comments.');
        final allComments = List<Comment>.from(state.comments)..addAll(newComments);
        emit(state.copyWith(
          status: CommentStatus.success,
          comments: allComments,
          hasMoreComments: allComments.length < state.totalCommentCount,
        ));
      },
    );
  }

  Future<void> _onRepliesRequested(_RepliesRequested event, Emitter<CommentState> emit) async {
    final parentId = event.parentCommentId;
    if (state.replyLoadStatus[parentId] == CommentStatus.loading) return;

    _log.info('⏬ Requesting replies for commentId: $parentId');

    // Cập nhật trạng thái tải cho bình luận cụ thể này
    final newReplyLoadStatus = Map<String, CommentStatus>.from(state.replyLoadStatus);
    newReplyLoadStatus[parentId] = CommentStatus.loading;
    emit(state.copyWith(replyLoadStatus: newReplyLoadStatus));

    final existingReplies = state.replies[parentId] ?? [];
    final result = await _commentRepository.getRepliesForComment(
      parentCommentId: parentId,
      limit: _kReplyPageLimit,
      startAfter: existingReplies.isNotEmpty ? existingReplies.last.createdAt : null,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to load replies for $parentId: $failure');
        newReplyLoadStatus[parentId] = CommentStatus.failure;
        emit(state.copyWith(replyLoadStatus: newReplyLoadStatus, failure: failure));
      },
      (newReplies) {
        _log.info('✅ Loaded ${newReplies.length} replies for $parentId.');
        final allReplies = List<CommentReply>.from(existingReplies)..addAll(newReplies);

        final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);
        newRepliesMap[parentId] = allReplies;

        final parentComment = state.comments.firstWhere((c) => c.commentId == parentId);
        final newHasMoreRepliesMap = Map<String, bool>.from(state.hasMoreReplies);
        newHasMoreRepliesMap[parentId] = allReplies.length < parentComment.replyCount;

        newReplyLoadStatus[parentId] = CommentStatus.success;

        emit(state.copyWith(
          replies: newRepliesMap,
          hasMoreReplies: newHasMoreRepliesMap,
          replyLoadStatus: newReplyLoadStatus,
        ));
      },
    );
  }

  Future<void> _onCommentSubmitted(_CommentSubmitted event, Emitter<CommentState> emit) async {
    final currentUser = _appUserRepository.latestUser!;
    _log.info('➕ Submitting new comment: "${event.content}" by ${currentUser.username}');

    // --- OPTIMISTIC UPDATE ---
    final tempId = _uuid.v4();
    final optimisticComment = Comment(
      commentId: tempId,
      authorUserId: currentUser.userId,
      authorUsername: currentUser.username!,
      authorAvatarUrl: currentUser.photoUrl,
      content: event.content,
      createdAt: DateTime.now(),
      likeCount: 0,
      replyCount: 0,
      isLiked: false,
    );

    final optimisticComments = [optimisticComment, ...state.comments];
    emit(state.copyWith(
      comments: optimisticComments,
      totalCommentCount: state.totalCommentCount + 1,
    ));
    _log.fine('✨ Optimistic comment added to UI.');

    // --- NETWORK CALL ---
    final result = await _commentRepository.createComment(
      postId: state.postId,
      content: event.content,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to submit comment. Reverting UI.', failure);
        // --- REVERT UI ON FAILURE ---
        final revertedComments = List<Comment>.from(state.comments)..removeWhere((c) => c.commentId == tempId);
        emit(state.copyWith(
          comments: revertedComments,
          totalCommentCount: state.totalCommentCount - 1,
          failure: failure, // Để UI có thể hiển thị snackbar
        ));
      },
      (_) {
        _log.info('✅ Comment submitted successfully to backend.');
        // Có thể re-fetch để lấy comment thật, nhưng tạm thời giữ optimistic là đủ
      },
    );
  }

  Future<void> _onReplySubmitted(_ReplySubmitted event, Emitter<CommentState> emit) async {
    if (state.replyTarget == null) {
      _log.severe('❌ Cannot submit reply, replyTarget is null.');
      return;
    }

    final currentUser = _appUserRepository.latestUser!;
    final target = state.replyTarget!;
    _log.info('↪️ Submitting reply to @${target.replyToUsername}: "${event.content}"');

    // --- OPTIMISTIC UPDATE ---
    final tempId = _uuid.v4();
    final optimisticReply = CommentReply(
      replyId: tempId,
      authorUserId: currentUser.userId,
      authorUsername: currentUser.username!,
      authorAvatarUrl: currentUser.photoUrl,
      replyToUserId: target.replyToUserId,
      replyToUsername: target.replyToUsername,
      content: event.content,
      createdAt: DateTime.now(),
      likeCount: 0,
      isLiked: false,
    );

    // Thêm reply vào map
    final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);
    final existingReplies = newRepliesMap[target.parentCommentId] ?? [];

    // =========================================================================
    // THAY ĐỔI Ở ĐÂY: Thêm trả lời mới vào CUỐI danh sách thay vì đầu danh sách
    //
    // TRƯỚC ĐÂY (Sắp xếp DESC):
    // newRepliesMap[target.parentCommentId] = [optimisticReply, ...existingReplies];
    //
    // BÂY GIỜ (Sắp xếp ASC):
    newRepliesMap[target.parentCommentId] = [...existingReplies, optimisticReply];
    // =========================================================================

    // Tăng reply_count của comment gốc
    final newComments = state.comments.map((c) {
      if (c.commentId == target.parentCommentId) {
        return c.copyWith(replyCount: c.replyCount + 1);
      }
      return c;
    }).toList();

    emit(state.copyWith(
      replies: newRepliesMap,
      comments: newComments,
      replyTarget: null, // Xóa target sau khi submit
    ));
    _log.fine('✨ Optimistic reply added to UI at the end of the list.');

    // --- NETWORK CALL ---
    final result = await _commentRepository.createReply(
      parentCommentId: target.parentCommentId,
      replyToUserId: target.replyToUserId,
      content: event.content,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to submit reply. Reverting UI.', failure);
        // --- REVERT UI ON FAILURE ---
        final revertedReplies = List<CommentReply>.from(state.replies[target.parentCommentId]!)..removeWhere((r) => r.replyId == tempId);
        newRepliesMap[target.parentCommentId] = revertedReplies;

        final revertedComments = state.comments.map((c) {
          if (c.commentId == target.parentCommentId) {
            return c.copyWith(replyCount: c.replyCount - 1);
          }
          return c;
        }).toList();

        emit(state.copyWith(
          replies: newRepliesMap,
          comments: revertedComments,
          failure: failure,
        ));
      },
      (_) => _log.info('✅ Reply submitted successfully to backend.'),
    );
  }

  void _onCommentLiked(_CommentLiked event, Emitter<CommentState> emit) {
    _log.info('👍 Liking comment ${event.commentId}, isLiked: ${event.isLiked}');
    // --- OPTIMISTIC UPDATE ---
    final newComments = state.comments.map((c) {
      if (c.commentId == event.commentId) {
        return c.copyWith(
          isLiked: event.isLiked,
          likeCount: c.likeCount + (event.isLiked ? 1 : -1),
        );
      }
      return c;
    }).toList();
    emit(state.copyWith(comments: newComments));

    // --- FIRE AND FORGET ---
    _commentRepository.likeComment(commentId: event.commentId, isLiked: event.isLiked);
  }

  void _onReplyLiked(_ReplyLiked event, Emitter<CommentState> emit) {
    _log.info('👍 Liking reply ${event.replyId}, isLiked: ${event.isLiked}');
    // --- OPTIMISTIC UPDATE ---
    final parentId = event.parentCommentId;
    final repliesForParent = state.replies[parentId];
    if (repliesForParent == null) return;

    final newRepliesForParent = repliesForParent.map((r) {
      if (r.replyId == event.replyId) {
        return r.copyWith(
          isLiked: event.isLiked,
          likeCount: r.likeCount + (event.isLiked ? 1 : -1),
        );
      }
      return r;
    }).toList();

    final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);
    newRepliesMap[parentId] = newRepliesForParent;
    emit(state.copyWith(replies: newRepliesMap));

    // --- FIRE AND FORGET ---
    _commentRepository.likeReply(replyId: event.replyId, isLiked: event.isLiked);
  }
}
