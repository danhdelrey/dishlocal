import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/moderation/repository/failure/moderation_failure.dart';

/// Repository chịu trách nhiệm cho các tác vụ kiểm duyệt.
abstract class ModerationRepository {

  Future<Either<ModerationFailure, void>> moderate({String? text, File? imageFile});


}
