import 'package:dishlocal/ui/features/view_post/view/post.dart';

abstract class PostRepository {
  Future<Post> getPosts();
}
