import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:dishlocal/ui/features/conversation_list/view/conversation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ConversationListBloc>()..add(const ConversationListEvent.started()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tin nhắn'),
        ),
        body: BlocBuilder<ConversationListBloc, ConversationListState>(
          builder: (context, state) {
            return switch (state) {
              ConversationListInitial() || ConversationListLoading() => const Center(child: CircularProgressIndicator()),
              ConversationListError(message: final message) => Center(
                  child: Text('Lỗi: $message\nKéo xuống để thử lại.'),
                ),
              ConversationListLoaded(conversations: final conversations) => RefreshIndicator(
                  onRefresh: () async {
                    context.read<ConversationListBloc>().add(const ConversationListEvent.refreshed());
                  },
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return ConversationTile(conversation: conversation);
                    },
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
