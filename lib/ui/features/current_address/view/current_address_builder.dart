import 'package:dishlocal/ui/features/current_address/bloc/current_address_bloc.dart';
import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentAddressBuilder extends StatelessWidget {
  const CurrentAddressBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(Position position) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentAddressBloc()..add(CurrentAddressRequested()),
      child: BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
        builder: (context, state) {
          if (state is CurrentAddressSuccess) {
            return builder(state.position);
          }
          return const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
            ),
          );
        },
      ),
    );
  }
}
