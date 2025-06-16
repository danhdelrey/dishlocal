import 'package:dishlocal/ui/features/view_post/view/small_post.dart';

abstract class PostRepository {
  Future<SmallPost> getPosts();
}
