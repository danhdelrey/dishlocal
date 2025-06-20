import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';

abstract class PostRepository {
  Future<Either<PostFailure, void>> createPost({required Post post, required File imageFile});
  Future<Either<PostFailure, List<Post>>> getPosts({
    int limit = 10,
    DateTime? startAfter,
  });
  Future<Either<PostFailure, List<Post>>> getPostWithId(String postId);
  Future<Either<PostFailure, void>> likePost({
    required String postId,
    required String userId,
    required bool isLiked, // true: like, false: unlike
  });

  Future<Either<PostFailure, void>> savePost({
    required String postId,
    required String userId,
    required bool isSaved, // true: save, false: unsave
  });
}
