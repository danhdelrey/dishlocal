import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'post_reaction_bar_event.dart';
part 'post_reaction_bar_state.dart';
part 'post_reaction_bar_bloc.freezed.dart';

@injectable
class PostReactionBarBloc extends Bloc<PostReactionBarEvent, PostReactionBarState> {
  final _log = Logger('PostReactionBarBloc');
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;

  // Các thuộc tính để lưu trữ thông tin của bài viết
  final String postId;
  final String? currentUserId;

  // Sử dụng @factoryParam để truyền dữ liệu ban đầu vào Bloc
  PostReactionBarBloc(
    this._postRepository,
    this._appUserRepository,
    @factoryParam Post post, // Nhận toàn bộ đối tượng Post ban đầu
  )   : postId = post.postId, // Lưu lại postId
        currentUserId = _appUserRepository.getCurrentUserId(), // Lấy và lưu userId
        super(
          // Khởi tạo state ban đầu từ dữ liệu THẬT của bài viết
          PostReactionBarState(
            likeCount: post.likeCount,
            isLiked: post.isLiked,
            saveCount: post.saveCount,
            isSaved: post.isSaved,
          ),
        ) {
    on<_LikeToggled>(_onLikeToggled);
    on<_SaveToggled>(_onSaveToggled);
  }

  // Xử lý khi người dùng nhấn nút Like/Unlike
  Future<void> _onLikeToggled(
    _LikeToggled event,
    Emitter<PostReactionBarState> emit,
  ) async {
    // 0. Kiểm tra xem người dùng đã đăng nhập chưa
    if (currentUserId == null) {
      _log.warning('Người dùng chưa đăng nhập, không thể thích bài viết.');
      // TODO: Ở đây bạn có thể emit một state hoặc event để yêu cầu đăng nhập
      return;
    }

    // 1. Cập nhật UI ngay lập tức (Optimistic Update)
    final oldState = state;
    final newIsLiked = !oldState.isLiked;
    final newLikeCount = newIsLiked ? oldState.likeCount + 1 : oldState.likeCount - 1;

    emit(state.copyWith(
      isLiked: newIsLiked,
      likeCount: newLikeCount,
    ));
    _log.info('UI được cập nhật tạm thời: isLiked=$newIsLiked, likeCount=$newLikeCount');

    // 2. Gọi Repository để thực hiện hành động thật
    final result = await _postRepository.likePost(
      postId: postId,
      userId: currentUserId!,
      isLiked: newIsLiked,
    );

    // 3. Xử lý kết quả trả về từ Repository
    result.fold(
      // L - Left (Thất bại)
      (failure) {
        _log.severe('Lỗi khi thích/bỏ thích bài viết $postId. Hoàn tác lại UI.');
        // Hoàn tác lại thay đổi trên UI nếu có lỗi
        emit(oldState);
        // TODO: Ở đây bạn có thể emit một state để hiển thị SnackBar lỗi
      },
      // R - Right (Thành công)
      (_) {
        _log.info('Thích/bỏ thích bài viết $postId thành công trên server.');
        // Không cần làm gì cả vì UI đã được cập nhật đúng
      },
    );
  }

  // Xử lý khi người dùng nhấn nút Save/Unsave
  Future<void> _onSaveToggled(
    _SaveToggled event,
    Emitter<PostReactionBarState> emit,
  ) async {
    // 0. Kiểm tra đăng nhập
    if (currentUserId == null) {
      _log.warning('Người dùng chưa đăng nhập, không thể lưu bài viết.');
      return;
    }

    // 1. Cập nhật UI ngay lập tức
    final oldState = state;
    final newIsSaved = !oldState.isSaved;
    final newSaveCount = newIsSaved ? oldState.saveCount + 1 : oldState.saveCount - 1;

    emit(state.copyWith(
      isSaved: newIsSaved,
      saveCount: newSaveCount,
    ));
    _log.info('UI được cập nhật tạm thời: isSaved=$newIsSaved, saveCount=$newSaveCount');

    // 2. Gọi Repository
    final result = await _postRepository.savePost(
      postId: postId,
      userId: currentUserId!,
      isSaved: newIsSaved,
    );

    // 3. Xử lý kết quả
    result.fold(
      (failure) {
        _log.severe('Lỗi khi lưu/bỏ lưu bài viết $postId. Hoàn tác lại UI.');
        emit(oldState);
      },
      (_) {
        _log.info('Lưu/bỏ lưu bài viết $postId thành công trên server.');
      },
    );
  }
}
