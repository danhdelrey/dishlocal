import 'package:dishlocal/ui/features/get_current_location/bloc/current_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationRender extends StatelessWidget {
  const CurrentLocationRender({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentLocationBloc()..add(CurrentLocationRequested()),
      child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
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
