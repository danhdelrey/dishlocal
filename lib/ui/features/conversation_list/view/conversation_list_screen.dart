import 'package:dishlocal/app/theme/theme.dart';
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
      // BLoC này bây giờ rất nhẹ, chỉ cần tạo ra là nó sẽ tự lắng nghe UnreadBadgeCubit
      create: (context) => getIt<ConversationListBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tin nhắn'),
          // Có thể thêm các action khác ở đây nếu cần
        ),
        // Sử dụng một Builder để có context mới chứa BlocProvider
        body: Builder(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              // Khi người dùng kéo để làm mới, gọi hàm refresh trong BLoC.
              // Hàm này sẽ trigger UnreadBadgeCubit để tải lại dữ liệu từ đầu.
              await context.read<ConversationListBloc>().refresh();
            },
            child: BlocBuilder<ConversationListBloc, ConversationListState>(
              builder: (context, state) {
                // Sử dụng switch expression để xử lý các trạng thái
                return switch (state) {
                  // Trạng thái Loading: Hiển thị vòng quay tải ở giữa
                  ConversationListLoading() => const Center(child: CircularProgressIndicator()),

                  // Trạng thái Loaded: Hiển thị danh sách hoặc thông báo rỗng
                  ConversationListLoaded(conversations: final conversations) => conversations.isEmpty
                      ? const Center(
                          child: Text(
                            'Chưa có cuộc trò chuyện nào.\nHãy bắt đầu nhắn tin với bạn bè!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: conversations.length,
                          itemBuilder: (context, index) {
                            final conversation = conversations[index];
                            return ConversationTile(conversation: conversation);
                          },
                        ),
                };
              },
            ),
          );
        }),
      ),
    );
  }
}
