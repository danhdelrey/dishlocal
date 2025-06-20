import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'view_post_event.dart';
part 'view_post_state.dart';
part 'view_post_bloc.freezed.dart';

@injectable
class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  final _log = Logger('ViewPostBloc');
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;

  ViewPostBloc(
    this._postRepository,
    this._appUserRepository,
  ) : super(const ViewPostState.loading()) {
    on<Started>(_onStarted);
  }

 Future<void> _onStarted(
    Started event,
    Emitter<ViewPostState> emit,
  ) async {
    _log.info('▶️ Bắt đầu xử lý sự kiện Started cho postId: ${event.post.postId}');
    emit(const ViewPostState.loading());

    try {
      // Bước 1: Lấy thông tin người dùng hiện tại
      final currentUserId = _appUserRepository.getCurrentUserId()!;
      _log.fine('🆔 Người dùng hiện tại: $currentUserId');

      // Bước 2: Lấy dữ liệu bài viết và tác giả SONG SONG
      // Đây là tối ưu lớn nhất: hai lệnh gọi mạng chính chạy cùng lúc.
      _log.fine('🔄 Bắt đầu lấy dữ liệu bài viết và tác giả song song...');
      final results = await Future.wait([
        _postRepository.getPostWithId(event.post.postId), // Lấy post (đã có like/save)
        _appUserRepository.getUserWithId(
          // Lấy tác giả (đã có follow)
          userId: event.post.authorUserId,
          currentUserId: currentUserId, // <-- TRUYỀN currentUserId VÀO ĐÂY
        ),
      ]);

      // Bước 3: Xử lý kết quả trả về
      final postResult = results[0] as Either<PostFailure, Post>;
      final authorResult = results[1] as Either<AppUserFailure, AppUser>;

      // Sử dụng getOrElse để xử lý lỗi một cách gọn gàng
      final post = postResult.getOrElse(() => throw 'Không thể tải bài viết');
      final author = authorResult.getOrElse(() => throw 'Không thể tải thông tin tác giả');

      _log.info('✅ Lấy bài viết và tác giả thành công. author.isFollowing: ${author.isFollowing}');

      // Bước 4: Emit trạng thái thành công
      _log.info('🎉 Tất cả dữ liệu đã sẵn sàng. Emit trạng thái Success.');
      emit(ViewPostState.success(
        post: post,
        author: author, // <-- Đối tượng author này đã chứa thông tin isFollowing
        currentUserId: currentUserId,
      ));
    } catch (error, stackTrace) {
      _log.severe(
        '❌ Đã xảy ra lỗi trong quá trình xử lý sự kiện Started.',
        error,
        stackTrace,
      );
      emit(const ViewPostState.failure());
    }
  }
}
