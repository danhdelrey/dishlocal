import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';
part 'conversation_list_bloc.freezed.dart';

@injectable
class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  final _log = Logger('ConversationListBloc');
  final ChatRepository _chatRepository;

  ConversationListBloc(this._chatRepository) : super(const ConversationListState.initial()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
  }

  Future<void> _onStarted(_Started event, Emitter<ConversationListState> emit) async {
    emit(const ConversationListState.loading());
    await _fetchConversations(emit);
  }

  Future<void> _onRefreshed(_Refreshed event, Emitter<ConversationListState> emit) async {
    // Không emit trạng thái loading để UI không bị giật khi refresh
    await _fetchConversations(emit);
  }

  Future<void> _fetchConversations(Emitter<ConversationListState> emit) async {
    try {
      final result = await _chatRepository.getMyConversations();
      result.fold(
        (failure) {
          _log.severe('Failed to fetch conversations: ${failure.message}');
          emit(ConversationListState.error(message: failure.message));
        },
        (conversations) {
          emit(ConversationListState.loaded(conversations: conversations));
        },
      );
    } catch (e) {
      _log.severe('Unexpected error fetching conversations', e);
      emit(const ConversationListState.error(message: 'Đã có lỗi không mong muốn xảy ra.'));
    }
  }
}
