import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/failure/post_failure.dart' as post_failure;
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

    // Bước 1: Lấy thông tin người dùng hiện tại một cách an toàn
    final currentUserId = _appUserRepository.getCurrentUserId(); // Bỏ dấu '!'
    _log.fine('🆔 Người dùng hiện tại: ${currentUserId ?? "Chưa đăng nhập"}');

    // Bước 2: Lấy dữ liệu bài viết và tác giả SONG SONG (giữ nguyên, rất tốt!)
    _log.fine('🔄 Bắt đầu lấy dữ liệu bài viết và tác giả song song...');
    final results = await Future.wait([
      _postRepository.getPostWithId(event.post.postId),
      _appUserRepository.getUserProfile(
        event.post.authorUserId,
      ),
    ]);

    // Bước 3: Xử lý kết quả trả về một cách an toàn
    final postResult = results[0] as Either<post_failure.PostFailure, Post>;
    final authorResult = results[1] as Either<AppUserFailure, AppUser>;

    // Bước 4: Sử dụng .fold() để xử lý cả hai trường hợp thành công và thất bại
    postResult.fold(
      // ---- TRƯỜNG HỢP 1: Lấy bài viết THẤT BẠI ----
      (postFailure) {
        _log.severe('❌ Lấy bài viết thất bại: $postFailure');

        final message = switch (postFailure) {
          // 1. Xử lý trường hợp cụ thể: Bài viết không tìm thấy
          post_failure.PostNotFoundFailure() => 'Bài viết này không còn tồn tại.',

          // 2. Sử dụng `_` để bắt tất cả các trường hợp lỗi còn lại (Unknown, PermissionDenied, etc.)
          //    và trả về một thông báo chung.
          _ => 'Không thể tải được bài viết. Vui lòng thử lại sau.'
        };

        emit(ViewPostState.failure(message));
      },
      // ---- TRƯỜDNG HỢP 2: Lấy bài viết THÀNH CÔNG, tiếp tục xử lý tác giả ----
      (post) {
        authorResult.fold(
          // ---- TRƯỜNG HỢP 2a: Lấy tác giả THẤT BẠI ----
          (authorFailure) {
            _log.severe('❌ Lấy tác giả thất bại: $authorFailure');

            // SỬ DỤNG SWITCH EXPRESSION ĐỂ DỊCH LỖI
            final message = switch (authorFailure) {
              UserNotFoundFailure() => 'Không tìm thấy thông tin tác giả.',
              // Thêm các trường hợp lỗi khác của AppUserFailure nếu cần
              _ => 'Không thể tải thông tin tác giả. Vui lòng thử lại.'
            };

            emit(ViewPostState.failure(message));
          },
          // ---- TRƯỜNG HỢP 2b: Lấy tác giả THÀNH CÔNG -> MỌI THỨ HOÀN HẢO ----
          (author) {
            _log.info('✅ Lấy bài viết và tác giả thành công.');
            _log.info('🎉 Tất cả dữ liệu đã sẵn sàng. Emit trạng thái Success.');
            emit(ViewPostState.success(
              post: post,
              author: author,
              currentUserId: currentUserId!,
            ));
          },
        );
      },
    );
  }
}
