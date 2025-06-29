// file: lib/data/repositories/comment/remote_comment_repository_sql_impl.dart

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/data/categories/comment/repository/failure/comment_failure.dart';
import 'package:dishlocal/data/categories/comment/repository/interface/comment_repository.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/entity/comment_reply_entity.dart';
import 'package:dishlocal/data/services/database_service/entity/post_comment_entity.dart';
import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/sql_database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: CommentRepository)
class RemoteCommentRepositorySqlImpl implements CommentRepository {
  final _log = Logger('RemoteCommentRepositorySqlImpl');
  final _supabase = Supabase.instance.client; // Dùng cho các thao tác RPC
  final SqlDatabaseService _dbService;
  final AuthenticationService _authenticationService;

  RemoteCommentRepositorySqlImpl(
    this._dbService,
    this._authenticationService,
  );

  /// Helper để bắt và dịch các lỗi phổ biến sang CommentFailure.
  Future<Either<CommentFailure, T>> _handleErrors<T>(Future<T> Function() future) async {
    try {
      return Right(await future());
    } on SqlDatabaseServiceException catch (e) {
      _log.severe('❌ Lỗi từ SqlDatabaseService trong Comment Repository', e);
      return Left(switch (e) {
        PermissionDeniedException() => const PermissionCommentFailure(),
        RecordNotFoundException() => const CommentNotFoundFailure(),
        UniqueConstraintViolationException() => const CommentOperationFailure('Bạn đã thực hiện hành động này rồi.'),
        CheckConstraintViolationException() => const CommentOperationFailure('Dữ liệu không hợp lệ.'),
        DatabaseConnectionException() => const ConnectionCommentFailure(),
        _ => const UnknownCommentFailure(),
      });
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Comment Repository', e, st);
      return const Left(UnknownCommentFailure());
    }
  }

  @override
  Future<Either<CommentFailure, List<Comment>>> getCommentsForPost({
    required String postId,
    int limit = 20,
    DateTime? startAfter,
  }) {
    return _handleErrors(() async {
      final currentUserId = _authenticationService.getCurrentUserId();
      _log.info('📡 Bắt đầu gọi RPC "get_post_comments" cho postId: $postId...');

      final params = {
        'p_post_id': postId,
        'p_user_id': currentUserId,
        'p_limit': limit,
        'p_cursor': startAfter?.toUtc().toIso8601String() ?? '9999-12-31',
      };

      _log.fine('   -> Với params: $params');
      final data = await _supabase.rpc('get_post_comments', params: params);

      if (data is! List) {
        _log.warning('⚠️ RPC "get_post_comments" không trả về một List. Kết quả: $data');
        return [];
      }

      final comments = data.map((json) => Comment.fromJson(json as Map<String, dynamic>)).toList();
      _log.info('✅ Lấy thành công ${comments.length} bình luận cho bài viết $postId.');
      return comments;
    });
  }

  @override
  Future<Either<CommentFailure, List<CommentReply>>> getRepliesForComment({
    required String parentCommentId,
    int limit = 10,
    DateTime? startAfter,
  }) {
    return _handleErrors(() async {
      final currentUserId = _authenticationService.getCurrentUserId();
      _log.info('📡 Bắt đầu gọi RPC "get_comment_replies" cho parentCommentId: $parentCommentId...');

      final params = {
        'p_parent_comment_id': parentCommentId,
        'p_user_id': currentUserId,
        'p_limit': limit,

        // =========================================================================
        // SỬA ĐỔI Ở ĐÂY: Thay đổi giá trị cursor mặc định cho logic ASC
        //
        // TRƯỚC ĐÂY (SAI):
        // 'p_cursor': startAfter?.toUtc().toIso8601String() ?? '9999-12-31',
        //
        // BÂY GIỜ (ĐÚNG):
        'p_cursor': startAfter?.toUtc().toIso8601String() ?? '1970-01-01',
        // =========================================================================
      };

      _log.fine('   -> Với params: $params');
      final data = await _supabase.rpc('get_comment_replies', params: params);

      if (data is! List) {
        _log.warning('⚠️ RPC "get_comment_replies" không trả về một List. Kết quả: $data');
        return [];
      }

      final replies = data.map((json) => CommentReply.fromJson(json as Map<String, dynamic>)).toList();
      _log.info('✅ Lấy thành công ${replies.length} trả lời cho bình luận $parentCommentId.');
      return replies;
    });
  }

  @override
  Future<Either<CommentFailure, Comment>> createComment({
    required String postId,
    required String content,
    required AppUser currentUser,
  }) {
    return _handleErrors(() async {
      final currentUserId = _authenticationService.getCurrentUserId();
      _log.info('➕ Bắt đầu tạo bình luận mới cho postId: $postId bởi user: $currentUserId');

      // Bây giờ chúng ta sẽ chờ kết quả trả về
      final createdData = await _dbService.create(
        tableName: 'post_comments',
        data: {
          'post_id': postId,
          'author_id': currentUserId,
          'content': content,
        },
        // Sử dụng fromJson của PostCommentEntity
        fromJson: PostCommentEntity.fromJson,
      );

      _log.info('🎉 Tạo bình luận thành công! ID thật: ${createdData.id}');

      

      // Chuyển đổi từ Entity sang Model UI
      return Comment(
        commentId: createdData.id,
        authorUserId: currentUser.userId,
        authorUsername: currentUser.username!,
        authorAvatarUrl: currentUser.photoUrl,
        content: createdData.content,
        createdAt: createdData.createdAt,
        likeCount: createdData.likeCount,
        replyCount: createdData.replyCount,
        isLiked: false, // Mới tạo nên chưa thể like
      );
    });
  }

  @override
  Future<Either<CommentFailure, CommentReply>> createReply({
    required String parentCommentId,
    required String content,
    required AppUser currentUser,
    required AppUser replyToUser,
  }) {
    return _handleErrors(() async {

      _log.info('↪️ Bắt đầu tạo trả lời cho parentCommentId: $parentCommentId...');

      final createdData = await _dbService.create(
        tableName: 'comment_replies',
        data: {
          'parent_comment_id': parentCommentId,
          'author_id': currentUser.userId,
          'reply_to_user_id': replyToUser.userId,
          'content': content,
        },
        fromJson: CommentReplyEntity.fromJson,
      );

      _log.info('🎉 Tạo trả lời thành công! ID thật: ${createdData.id}');

      return CommentReply(
        replyId: createdData.id,
        authorUserId: currentUser.userId,
        authorUsername: currentUser.username!,
        authorAvatarUrl: currentUser.photoUrl,
        replyToUserId: replyToUser.userId,
        replyToUsername: replyToUser.username!,
        content: createdData.content,
        createdAt: createdData.createdAt,
        likeCount: createdData.likeCount,
        isLiked: false,
      );
    });
  }

  /// Helper chung để xử lý logic thích/bỏ thích
  Future<void> _handleLikeUnlike({
    required String tableName,
    required String entityIdColumnName,
    required String entityId,
    required bool isLiked,
  }) async {
    final currentUserId = _authenticationService.getCurrentUserId();
    final action = isLiked ? "thích" : "bỏ thích";
    _log.info('🔄 Bắt đầu $action $entityIdColumnName: $entityId bởi user: $currentUserId.');

    if (isLiked) {
      await _dbService.create(
        tableName: tableName,
        data: {entityIdColumnName: entityId, 'user_id': currentUserId},
        fromJson: (json) => {},
      );
    } else {
      await _dbService.deleteWhere(
        tableName: tableName,
        filters: {entityIdColumnName: entityId, 'user_id': currentUserId},
      );
    }
    _log.info('✅ Hoàn thành $action thành công.');
  }

  @override
  Future<Either<CommentFailure, void>> likeComment({required String commentId, required bool isLiked}) {
    return _handleErrors(() => _handleLikeUnlike(
          tableName: 'post_comment_likes',
          entityIdColumnName: 'comment_id',
          entityId: commentId,
          isLiked: isLiked,
        ));
  }

  @override
  Future<Either<CommentFailure, void>> likeReply({required String replyId, required bool isLiked}) {
    return _handleErrors(() => _handleLikeUnlike(
          tableName: 'comment_reply_likes',
          entityIdColumnName: 'reply_id',
          entityId: replyId,
          isLiked: isLiked,
        ));
  }

  @override
  Future<Either<CommentFailure, void>> deleteComment({required String commentId}) {
    return _handleErrors(() async {
      _log.info('🗑️ Bắt đầu xóa bình luận ID: $commentId...');
      await _dbService.delete(tableName: 'post_comments', id: commentId);
      _log.info('✅ Xóa bình luận $commentId thành công.');
    });
  }

  @override
  Future<Either<CommentFailure, void>> deleteReply({required String replyId}) {
    return _handleErrors(() async {
      _log.info('🗑️ Bắt đầu xóa trả lời ID: $replyId...');
      await _dbService.delete(tableName: 'comment_replies', id: replyId);
      _log.info('✅ Xóa trả lời $replyId thành công.');
    });
  }
}
