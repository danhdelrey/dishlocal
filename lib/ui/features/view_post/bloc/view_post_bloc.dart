import 'dart:async';

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

  // THÊM MỘT BIẾN ĐỂ THEO DÕI THỜI GIAN
  Timer? _viewDurationTimer;
  final _stopwatch = Stopwatch();

  ViewPostBloc(
    this._postRepository,
    this._appUserRepository,
  ) : super(const ViewPostState.loading()) {
    on<Started>(_onStarted);
    // THÊM XỬ LÝ SỰ KIỆN KHI BLOC BỊ HỦY
    on<PageExited>(_onPageExited);
  }

  @override
  Future<void> close() {
    // Đảm bảo timer được hủy khi bloc bị dispose
    _viewDurationTimer?.cancel();
    _stopwatch.stop();
    return super.close();
  }

  /// Xử lý khi người dùng rời khỏi trang xem bài viết.
  Future<void> _onPageExited(
    PageExited event,
    Emitter<ViewPostState> emit,
  ) async {
    _viewDurationTimer?.cancel();
    _stopwatch.stop();

    final durationMs = _stopwatch.elapsedMilliseconds;
    // Chỉ ghi nhận nếu người dùng đã ở lại trang ít nhất một khoảng thời gian ngắn
    // (ví dụ: 1 giây) để tránh ghi nhận các lượt xem "lướt qua".
    if (durationMs > 1000) {
      _log.info(
        '🚪 Người dùng rời khỏi trang. Ghi nhận thời gian xem: ${durationMs}ms cho postId: ${event.postId}',
      );
      // Gọi "fire-and-forget"
      unawaited(_postRepository.recordPostView(
        postId: event.postId,
        durationInMs: durationMs,
      ));
    } else {
      _log.info(
        '🚪 Người dùng rời khỏi trang quá nhanh (${durationMs}ms). Không ghi nhận thời gian xem.',
      );
    }
  }

  Future<void> _onStarted(
    Started event,
    Emitter<ViewPostState> emit,
  ) async {
    _log.info('▶️ Bắt đầu xử lý sự kiện Started cho postId: ${event.post.postId}');
    emit(const ViewPostState.loading());

    // Bước 1: Lấy thông tin người dùng hiện tại
    final currentUserId = _appUserRepository.getCurrentUserId();
    _log.fine('🆔 Người dùng hiện tại: ${currentUserId ?? "Chưa đăng nhập"}');

    // Bước 2: Lấy dữ liệu bài viết và tác giả song song
    _log.fine('🔄 Bắt đầu lấy dữ liệu bài viết và tác giả song song...');
    final results = await Future.wait([
      _postRepository.getPostWithId(event.post.postId),
      _appUserRepository.getUserProfile(
        event.post.authorUserId,
      ),
    ]);

    // Bước 3: Xử lý kết quả trả về
    final postResult = results[0] as Either<post_failure.PostFailure, Post>;
    final authorResult = results[1] as Either<AppUserFailure, AppUser>;

    // Bước 4: Sử dụng .fold() để xử lý các trường hợp
    postResult.fold(
      (postFailure) {
        _log.severe('❌ Lấy bài viết thất bại: $postFailure');
        final message = switch (postFailure) { post_failure.PostNotFoundFailure() => 'Bài viết này không còn tồn tại.', _ => 'Không thể tải được bài viết. Vui lòng thử lại sau.' };
        emit(ViewPostState.failure(message));
      },
      (post) {
        // ---- TÍCH HỢP LOGIC GHI NHẬN LƯỢT XEM TẠI ĐÂY ----
        // Ngay khi có thông tin bài viết, chúng ta bắt đầu ghi nhận.
        _log.info('📝 Ghi nhận lượt xem ban đầu cho postId: ${post.postId}');

        // 1. Ghi nhận lượt xem ban đầu (không có thời gian xem)
        // Chúng ta không chờ (await) kết quả. Nếu nó thất bại, cũng không ảnh hưởng đến UI.
        unawaited(_postRepository.recordPostView(postId: post.postId));

        // 2. Bắt đầu đếm thời gian xem
        _stopwatch
          ..reset()
          ..start();

        // 3. Xử lý kết quả của tác giả
        authorResult.fold(
          (authorFailure) {
            _log.severe('❌ Lấy tác giả thất bại: $authorFailure');
            final message = switch (authorFailure) { UserNotFoundFailure() => 'Không tìm thấy thông tin tác giả.', _ => 'Không thể tải thông tin tác giả. Vui lòng thử lại.' };
            emit(ViewPostState.failure(message));
          },
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
