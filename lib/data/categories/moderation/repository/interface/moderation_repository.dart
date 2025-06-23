import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/moderation/repository/failure/moderation_failure.dart';

/// Repository chịu trách nhiệm cho các tác vụ kiểm duyệt.
abstract class ModerationRepository {
  /// Kiểm duyệt một hình ảnh trước khi đăng.
  ///
  /// - Trả về `Right(null)` nếu ảnh an toàn.
  /// - Trả về `Left(ModerationFailure)` nếu ảnh không an toàn hoặc có lỗi.
  Future<Either<ModerationFailure, void>> moderateImage(File imageFile);
}
