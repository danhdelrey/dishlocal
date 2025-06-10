import 'package:dishlocal/ui/features/get_current_location/bloc/current_location_bloc.dart';
import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationRender extends StatelessWidget {
  const CurrentLocationRender({
    super.key,
    required this.builder,
  });

  final Widget Function(Position position) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentLocationBloc()..add(CurrentLocationRequested()),
      child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
        builder: (context, state) {
          if (state is CurrentLocationSuccess) {
            return builder(state.position);
          }
          return const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Đang tìm kiếm vị trí...',
            ),
          );
        },
      ),
    );
  }
}
