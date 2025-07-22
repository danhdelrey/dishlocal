import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'share_post_state.dart';
part 'share_post_cubit.freezed.dart';

@injectable
class SharePostCubit extends Cubit<SharePostState> {
  final ChatRepository _chatRepository;

  SharePostCubit(this._chatRepository) : super(const SharePostState.initial());

  Future<void> fetchConversations() async {
    emit(const SharePostState.loading());
    final result = await _chatRepository.getMyConversations();
    result.fold(
      (failure) => emit(SharePostState.error(failure.message)),
      (conversations) => emit(SharePostState.loaded(conversations)),
    );
  }

  Future<void> sendPost({
    required String postId,
    required String conversationId,
    required AppUser otherUser,
  }) async {
    // Không cần emit loading vì UI sẽ tự đóng
    final result = await _chatRepository.sendMessage(
      conversationId: conversationId,
      sharedPostId: postId,
    );

    result.fold(
      (failure) => emit(SharePostState.sendError(failure.message)),
      (sentMessage) => emit(SharePostState.sendSuccess(
        conversationId: conversationId,
        otherUser: otherUser,
      )),
    );
  }
}
