import 'package:dishlocal/data/error/repository_failure.dart';

sealed class PostFailure extends RepositoryFailure {
  const PostFailure(super.message);
}

class UnknownFailure extends PostFailure {
  const UnknownFailure() : super('Lỗi không xác định khi lấy bài đăng');
}
