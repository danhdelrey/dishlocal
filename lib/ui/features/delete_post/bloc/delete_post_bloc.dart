import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';
part 'delete_post_bloc.freezed.dart';

@injectable
class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final _log = Logger('DeletePostBloc');
  final PostRepository _postRepository;

  DeletePostBloc(this._postRepository) : super(const DeletePostState.initial()) {
    on<DeletePostRequested>(_onDeletePostRequested);
  }

  FutureOr<void> _onDeletePostRequested(
    DeletePostRequested event,
    Emitter<DeletePostState> emit,
  ) async {
    _log.info('▶️ Nhận được sự kiện DeletePostRequested cho postId: ${event.post.postId}');

    // 1. Chuyển sang trạng thái loading để UI có thể hiển thị chỉ báo.
    _log.info('⏳ Phát ra trạng thái: [Loading]');
    emit(const DeletePostState.loading());

    // 2. Gọi phương thức deletePost từ repository.
    _log.info('📡 Đang gọi _postRepository.deletePost...');
    final result = await _postRepository.deletePost(postId: event.post.postId);

    // 3. Xử lý kết quả trả về từ repository.
    result.fold(
      // 3a. Trường hợp thất bại (Left)
      (failure) {
        _log.severe('❌ Xóa bài viết thất bại. Failure: ${failure.message}');

        // Dựa vào loại failure, bạn có thể thực hiện các hành động khác nhau
        // ở đây nếu cần, ví dụ: phân tích log, v.v.
        // Hiện tại, chúng ta chỉ cần phát ra trạng thái failure.

        _log.info('💥 Phát ra trạng thái: [Failure]');
        emit(const DeletePostState.failure());
      },
      // 3b. Trường hợp thành công (Right)
      (_) {
        _log.info('✅ Xóa bài viết thành công!');
        _log.info('🎉 Phát ra trạng thái: [Success]');
        emit(const DeletePostState.success());
      },
    );
  }
}
