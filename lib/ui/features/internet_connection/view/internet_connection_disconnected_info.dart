import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';

class InternetConnectionDisconnectedInfo extends StatelessWidget {
  const InternetConnectionDisconnectedInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 40,
            color: appColorScheme(context).onSurface,
          ),
          Text(
            'Không có kết nối internet',
            style: appTextTheme(context).titleMedium,
          ),
          Text(
            'Vui lòng kiểm tra lại kết nối của bạn.',
            style: appTextTheme(context).labelLarge,
          ),
        ],
      ),
    );
  }
}
