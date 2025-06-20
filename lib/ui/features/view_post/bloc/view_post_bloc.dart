import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
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
      // BƯỚC 1: Lấy dữ liệu bài viết (đã được làm giàu) từ repository.
      // Repository đã xử lý việc kiểm tra like, save, follow.
      _log.fine('🔄 Đang gọi _postRepository.getPostWithId...');
      final postResult = await _postRepository.getPostWithId(event.post.postId);

      // Xử lý ngay lập tức nếu không lấy được bài viết
      final post = postResult.getOrElse(() {
        _log.severe('❌ Không thể lấy dữ liệu bài viết. Ném lỗi để dừng tiến trình.');
        // Ném một lỗi để bắt ở khối catch bên ngoài.
        // Điều này giúp code gọn hơn so với việc lồng các khối fold.
        throw 'Không thể tải bài viết';
      });
      _log.info('✅ Lấy dữ liệu bài viết thành công. authorId: ${post.authorUserId}');

      // BƯỚC 2: Lấy thông tin người dùng hiện tại và thông tin tác giả SONG SONG.
      // Điều này tối ưu hơn việc chờ lấy post xong mới lấy author.
      _log.fine('🔄 Bắt đầu lấy thông tin người dùng hiện tại và tác giả song song...');

      final results = await Future.wait([
        Future.value(_appUserRepository.getCurrentUserId()), // Không phải là async, nhưng bọc trong Future để đồng bộ
        _appUserRepository.getUserWithId(post.authorUserId),
      ]);

      // BƯỚC 3: Xử lý kết quả trả về
      final currentUserId = results[0] as String;
      final authorResult = results[1] as Either<AppUserFailure, AppUser>;

      final author = authorResult.getOrElse(() {
        _log.severe('❌ Không thể lấy dữ liệu tác giả. Ném lỗi để dừng tiến trình.');
        throw 'Không thể tải thông tin tác giả';
      });

      _log.info('✅ Lấy thông tin tác giả thành công: ${author.displayName}');
      _log.fine('🆔 Người dùng hiện tại: $currentUserId');

      // BƯỚC 4: Emit trạng thái thành công với tất cả dữ liệu
      _log.info('🎉 Tất cả dữ liệu đã sẵn sàng. Emit trạng thái Success.');
      emit(ViewPostState.success(
        post: post,
        author: author,
        currentUserId: currentUserId,
      ));
    } catch (error, stackTrace) {
      // BƯỚC 5: Bắt tất cả các lỗi có thể xảy ra ở các bước trên
      _log.severe(
        '❌ Đã xảy ra lỗi trong quá trình xử lý sự kiện Started.',
        error,
        stackTrace,
      );
      emit(const ViewPostState.failure());
    }
  }
}
