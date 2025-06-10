import 'package:dishlocal/ui/features/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationText extends StatelessWidget {
  const CurrentLocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LocationSuccess) {
            return Text('${state.position.longitude}   ${state.position.latitude}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
