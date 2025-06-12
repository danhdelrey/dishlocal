import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionBuilder extends StatelessWidget {
  const InternetConnectionBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(bool hasInternetAccess) builder;

  @override
  Widget build(BuildContext context) {
    // Dùng FutureBuilder để lấy trạng thái ban đầu
    return FutureBuilder<bool>(
      future: InternetConnection().hasInternetAccess,
      builder: (context, futureSnapshot) {
        // Nếu chưa lấy xong trạng thái ban đầu -> loading
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Kiểm tra kết nối...',
            ),
          );
        }

        // Lấy trạng thái ban đầu từ future
        final initialStatus = futureSnapshot.data ?? false;

        // Dùng StreamBuilder để lắng nghe các thay đổi
        return StreamBuilder<InternetStatus>(
          stream: InternetConnection().onStatusChange,
          // Cung cấp trạng thái ban đầu cho stream
          initialData: initialStatus ? InternetStatus.connected : InternetStatus.disconnected,
          builder: (context, streamSnapshot) {
            final status = streamSnapshot.data!;
            return builder(status == InternetStatus.connected);
          },
        );
      },
    );
  }
}
