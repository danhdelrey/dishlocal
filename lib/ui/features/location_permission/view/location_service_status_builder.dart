import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceStatusBuilder extends StatelessWidget {
  const LocationServiceStatusBuilder({super.key, required this.builder});

  final Widget Function(bool enabled) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Geolocator.getServiceStatusStream(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return const SizedBox();
        }
        return builder(asyncSnapshot.data == ServiceStatus.enabled);
      },
    );
  }
}
