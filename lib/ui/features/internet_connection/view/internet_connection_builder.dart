import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionBuilder extends StatelessWidget {
  const InternetConnectionBuilder({super.key, required this.builder, required this.defaultChild});

  final Widget Function(bool isInternetAvailable) builder;
  final Widget defaultChild;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnection().onStatusChange,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          switch (asyncSnapshot.data!) {
            case InternetStatus.connected:
              return builder(true);
            case InternetStatus.disconnected:
              return builder(false);
          }
        }
        return defaultChild;
      },
    );
  }
}
