import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/view_post/view/post.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class RemotePostRepositoryImpl implements PostRepository {
  @override
  Future<Post> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
}