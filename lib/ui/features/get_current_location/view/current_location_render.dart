import 'package:dishlocal/ui/features/get_current_location/bloc/current_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationRender extends StatelessWidget {
  const CurrentLocationRender({super.key, required this.child, required this.onCurrentLocationSuccess});

  final Widget child;
  final Function(Position position) onCurrentLocationSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentLocationBloc()..add(CurrentLocationRequested()),
      child: BlocConsumer<CurrentLocationBloc, CurrentLocationState>(
        listener: (context, state) {
          if (state is CurrentLocationSuccess) {
            onCurrentLocationSuccess(state.position);
          }
        },
        builder: (context, state) {
          if (state is CurrentLocationSuccess) {
            return child;
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
