import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'view_post_event.dart';
part 'view_post_state.dart';
part 'view_post_bloc.freezed.dart';

@injectable
class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;
  ViewPostBloc(this._postRepository, this._appUserRepository) : super(const Loading()) {
    on<Started>((event, emit) async {
      emit(const ViewPostState.loading());
      final fetchedPost = await _postRepository.getPostWithId(event.post.postId);
      fetchedPost.fold(
        (failure) {
          emit(const ViewPostState.failure());
        },
        (post) {
          emit(ViewPostState.success(post: post, currentUserId: _appUserRepository.getCurrentUserId()!));
        },
      );
    });
  }
}
