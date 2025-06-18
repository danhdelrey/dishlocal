// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:dishlocal/ui/features/view_post/view/small_post.dart';

@LazySingleton(as: PostRepository)
class RemotePostRepositoryImpl implements PostRepository {
  final _log = Logger('RemotePostRepositoryImpl');
  final DatabaseService _databaseService;
  final StorageService _storageService;
  RemotePostRepositoryImpl(
    this._databaseService,
    this._storageService,
  );

  @override
  Future<Either<PostFailure, void>> createNewPost(Post newPost) async {
    try {
      await _databaseService.setDocument(collection: 'posts', docId: newPost.postId, data: newPost.toJson());
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, String>> uploadPostImage(File imageFile, String postId) async {
    try {
      final imageUrl = await _storageService.uploadFile(path: 'posts/$postId/${imageFile.path.split('/').last}', file: imageFile);
      return Right(imageUrl);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
