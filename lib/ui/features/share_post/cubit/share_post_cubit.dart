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

  Future<void> sendPostToMultiple({
    required String postId,
    required List<Conversation> conversations,
  }) async {
    // Không cần emit loading vì UI sẽ tự đóng ngay lập tức
    
    // Sử dụng Future.wait để gửi tất cả các tin nhắn song song
    final sendFutures = conversations.map((convo) {
      return _chatRepository.sendMessage(
        conversationId: convo.conversationId,
        sharedPostId: postId,
      );
    }).toList();

    // Chờ tất cả các request gửi đi hoàn tất
    final results = await Future.wait(sendFutures);
    
    // Kiểm tra xem có lỗi nào không
    final bool allSuccess = results.every((result) => result.isRight());
    
    if (allSuccess) {
      // Nếu tất cả đều thành công, emit trạng thái thành công
      // Chúng ta sẽ hiển thị tên của người đầu tiên và số lượng
      final firstRecipient = conversations.first.otherParticipant;
      final totalRecipients = conversations.length;
      
      emit(SharePostState.sendSuccess(
        recipient: firstRecipient,
        totalSent: totalRecipients,
        // Cung cấp conversationId của người đầu tiên để có thể điều hướng nếu cần
        firstConversationId: conversations.first.conversationId,
      ));
    } else {
      // Nếu có ít nhất một lỗi, emit trạng thái lỗi chung
      emit(const SharePostState.sendError('Gửi tin nhắn đến một vài người đã thất bại.'));
    }
  }

}
