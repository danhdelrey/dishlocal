import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionAvailability extends StatelessWidget {
  const InternetConnectionAvailability({
    super.key,
    required this.childWhenConnected,
    required this.childWhenDisconnected,
    required this.initialChild,
  });

  final Widget childWhenConnected;
  final Widget childWhenDisconnected;
  final Widget initialChild;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnection().onStatusChange,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          switch (asyncSnapshot.data!) {
            case InternetStatus.connected:
              return childWhenConnected;
            case InternetStatus.disconnected:
              return childWhenDisconnected;
          }
        }
        return initialChild;
      },
    );
  }
}
