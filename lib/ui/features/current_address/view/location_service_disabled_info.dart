import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceDisabledInfo extends StatelessWidget {
  const LocationServiceDisabledInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 40,
            color: appColorScheme(context).onSurface,
          ),
          Text(
            'Dịch vụ vị trí đã tắt',
            style: appTextTheme(context).titleMedium,
          ),
          Text(
            'Vui lòng bật dịch vụ vị trí để tiếp tục.',
            style: appTextTheme(context).labelLarge,
          ),
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
            },
            child: const Text(
              'Mở cài đặt',
            ),
          ),
        ],
      ),
    );
  }
}
