// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
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
  final AppUserRepository _appUserRepository;
  final StorageService _storageService;
  final DatabaseService _databaseService;

  RemotePostRepositoryImpl(this._appUserRepository, this._storageService, this._databaseService);
  @override
  Future<Either<PostFailure, void>> createPost({required Post post, required File imageFile}) async {
    try {
      final url = await _storageService.uploadFile(path: 'path', file: imageFile, publicId: post.postId);
      await _databaseService.setDocument(collection: 'posts', docId: post.postId, data: post.copyWith(imageUrl: url).toJson());
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
