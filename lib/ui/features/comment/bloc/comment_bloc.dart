// file: lib/application/comment/comment_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
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
    on<_CommentDeleted>(_onCommentDeleted);
    on<_ReplyDeleted>(_onReplyDeleted);
  }

  Future<void> _onInitialized(_Initialized event, Emitter<CommentState> emit) async {
    _log.info('▶️ Initializing CommentBloc for postId: ${event.postId} with total count: ${event.totalCommentCount}');
    emit(state.copyWith(
      postId: event.postId,
      totalCommentCount: event.totalCommentCount,
      currentUser: _appUserRepository.latestUser,
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
      currentUser: _appUserRepository.latestUser!,
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
      (realComment) {
        _log.info('✅ Comment submitted. Replacing temp id $tempId with real id ${realComment.commentId}');
        // --- THAY THẾ ID THẬT ---
        final finalComments = state.comments.map((comment) {
          if (comment.commentId == tempId) {
            // Trả về comment thật từ server với ID đúng
            return realComment;
          }
          return comment;
        }).toList();

        emit(state.copyWith(comments: finalComments));
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

    final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);

    // =========================================================================
    // LOGIC ĐIỀU KIỆN MỚI (PHIÊN BẢN 2)
    // Kiểm tra xem người dùng đã tải HẾT TẤT CẢ các trả lời chưa
    // bằng cách kiểm tra cờ `hasMoreReplies` cho bình luận đó.
    // `hasMoreReplies[key] == false` có nghĩa là đã tải hết.
    // `hasMoreReplies[key]` là null hoặc true nghĩa là chưa tải hết.
    // =========================================================================
    final bool allRepliesLoaded = state.hasMoreReplies[target.parentCommentId] == false;

    if (allRepliesLoaded) {
      // TRƯỜNG HỢP 1: TẤT CẢ replies đã được tải. Thêm reply lạc quan vào UI.
      _log.fine('✨ All replies are loaded. Adding optimistic reply to UI.');
      final existingReplies = newRepliesMap[target.parentCommentId] ?? [];
      newRepliesMap[target.parentCommentId] = [...existingReplies, optimisticReply];
    } else {
      // TRƯỜNG HỢP 2: Vẫn còn replies chưa tải. Chỉ tăng bộ đếm.
      _log.fine('✨ Not all replies are loaded. Only incrementing reply count.');
    }

    // Luôn luôn tăng bộ đếm `replyCount` của comment gốc.
    final newComments = state.comments.map((c) {
      if (c.commentId == target.parentCommentId) {
        return c.copyWith(replyCount: c.replyCount + 1);
      }
      return c;
    }).toList();

    emit(state.copyWith(
      replies: newRepliesMap,
      comments: newComments,
      replyTarget: null,
    ));

    final targetUserResult = await _appUserRepository.getUserProfile(target.replyToUserId);
    if (targetUserResult.isLeft()) {
      _log.severe('❌ Failed to fetch target user profile for reply: ${target.replyToUserId}');
      return;
    }
    final targetUser = targetUserResult.getOrElse(() => throw Exception('Target user not found'));

    // --- NETWORK CALL (luôn được thực hiện) ---
    final result = await _commentRepository.createReply(
      parentCommentId: target.parentCommentId,
      replyToUser: targetUser,
      currentUser: currentUser,
      content: event.content,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Failed to submit reply. Reverting UI.', failure);
        // --- REVERT UI ON FAILURE ---

        // Chỉ revert UI nếu reply lạc quan đã được thêm vào trước đó
        if (allRepliesLoaded) {
          final revertedReplies = List<CommentReply>.from(state.replies[target.parentCommentId]!)..removeWhere((r) => r.replyId == tempId);
          newRepliesMap[target.parentCommentId] = revertedReplies;
        }

        // Luôn revert bộ đếm
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
      (realReply) {
        _log.info('✅ Reply submitted. Replacing temp id $tempId with real id ${realReply.replyId}');
        // --- THAY THẾ ID THẬT ---
        final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);
        final repliesForParent = newRepliesMap[target.parentCommentId]!;

        final finalReplies = repliesForParent.map((reply) {
          if (reply.replyId == tempId) {
            return realReply;
          }
          return reply;
        }).toList();

        newRepliesMap[target.parentCommentId] = finalReplies;
        emit(state.copyWith(replies: newRepliesMap));
      },
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

  Future<void> _onCommentDeleted(_CommentDeleted event, Emitter<CommentState> emit) async {
    _log.info('🗑️ Deleting comment ${event.commentId}');

    // --- OPTIMISTIC UPDATE ---
    final commentToDelete = state.comments.firstWhere((c) => c.commentId == event.commentId);
    final replyCountOfDeletedComment = commentToDelete.replyCount;

    // 1. Xóa bình luận khỏi danh sách
    final optimisticComments = List<Comment>.from(state.comments)
      ..removeWhere((c) => c.commentId == event.commentId);
    
    // 2. Xóa các replies liên quan khỏi state (nếu đã được tải)
    final optimisticReplies = Map<String, List<CommentReply>>.from(state.replies)
      ..remove(event.commentId);

    // 3. Cập nhật tổng số bình luận
    // (Bao gồm cả bình luận gốc và tất cả các trả lời của nó)
    final newTotalCount = state.totalCommentCount - (1 + replyCountOfDeletedComment);

    emit(state.copyWith(
      comments: optimisticComments,
      replies: optimisticReplies,
      totalCommentCount: newTotalCount,
    ));
    _log.fine('✨ Optimistic delete for comment ${event.commentId} applied to UI.');

    // --- NETWORK CALL ---
    final result = await _commentRepository.deleteComment(commentId: event.commentId);

    result.fold(
      (failure) {
        _log.severe('❌ Failed to delete comment. Reverting UI.', failure);
        // --- REVERT UI ON FAILURE ---
        // Đơn giản là phát lại trạng thái ngay trước khi xóa
        // Cách tiếp cận đơn giản hơn: có thể chỉ cần fetch lại toàn bộ.
        // Nhưng ở đây chúng ta sẽ thêm lại. Việc này phức tạp, nên cách đơn giản
        // nhất là chỉ hiển thị lỗi và để người dùng tự refresh.
        // Để đơn giản, chúng ta chỉ hiển thị lỗi.
        emit(state.copyWith(failure: failure));
        // NOTE: Việc revert một hành động xóa phức tạp. Cách tiếp cận đơn giản nhất
        // là hiển thị lỗi và khuyến khích người dùng làm mới. Hoặc ta có thể
        // reload lại toàn bộ comment list.
      },
      (_) {
        _log.info('✅ Comment ${event.commentId} deleted successfully from backend.');
        // Không cần làm gì thêm vì UI đã được cập nhật
      },
    );
  }

  Future<void> _onReplyDeleted(_ReplyDeleted event, Emitter<CommentState> emit) async {
    _log.info('🗑️ Deleting reply ${event.replyId} from parent ${event.parentCommentId}');
    
    // --- OPTIMISTIC UPDATE ---
    
    // 1. Xóa reply khỏi map
    final newRepliesMap = Map<String, List<CommentReply>>.from(state.replies);
    final repliesForParent = List<CommentReply>.from(newRepliesMap[event.parentCommentId]!)
      ..removeWhere((r) => r.replyId == event.replyId);
    newRepliesMap[event.parentCommentId] = repliesForParent;

    // 2. Giảm reply_count và total_comment_count
    final newComments = state.comments.map((c) {
      if (c.commentId == event.parentCommentId) {
        return c.copyWith(replyCount: c.replyCount - 1);
      }
      return c;
    }).toList();

    emit(state.copyWith(
      replies: newRepliesMap,
      comments: newComments,
      totalCommentCount: state.totalCommentCount - 1,
    ));
    _log.fine('✨ Optimistic delete for reply ${event.replyId} applied to UI.');

    // --- NETWORK CALL ---
    final result = await _commentRepository.deleteReply(replyId: event.replyId);

    result.fold(
      (failure) {
        _log.severe('❌ Failed to delete reply. Reverting UI.', failure);
        emit(state.copyWith(failure: failure));
      },
      (_) {
        _log.info('✅ Reply ${event.replyId} deleted successfully from backend.');
      },
    );
  }

}
