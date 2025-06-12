import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceStatusBuilder extends StatelessWidget {
  const LocationServiceStatusBuilder({super.key, required this.builder});

  final Widget Function(bool enabled) builder;

  @override
  Widget build(BuildContext context) {
    // Dùng FutureBuilder để lấy trạng thái ban đầu
    return FutureBuilder<bool>(
      future: Geolocator.isLocationServiceEnabled(),
      builder: (context, futureSnapshot) {
        // Nếu chưa lấy xong trạng thái ban đầu -> loading
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Kiểm tra dịch vụ vị trí...',
            ),
          );
        }

        // Lấy trạng thái ban đầu từ future
        final initialStatus = futureSnapshot.data ?? false;

        // Dùng StreamBuilder để lắng nghe các thay đổi
        return StreamBuilder<ServiceStatus>(
          stream: Geolocator.getServiceStatusStream(),
          // Cung cấp trạng thái ban đầu cho stream
          initialData: initialStatus ? ServiceStatus.enabled : ServiceStatus.disabled,
          builder: (context, streamSnapshot) {
            final status = streamSnapshot.data!;
            return builder(status == ServiceStatus.enabled);
          },
        );
      },
    );
  }
}
