import 'package:flutter/material.dart';

class InternetDisconnected extends StatelessWidget {
  const InternetDisconnected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // Canh giữa các thành phần theo chiều dọc và ngang
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded, // Icon trực quan
            size: 40,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16), // Khoảng cách giữa icon và chữ
          Text(
            'Không có kết nối Internet',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  //fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Vui lòng kiểm tra lại kết nối của bạn.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  //fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
