import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/current_address/bloc/current_address_bloc.dart';
import 'package:dishlocal/ui/features/current_address/view/location_service_disabled_info.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentAddressBuilder extends StatelessWidget {
  const CurrentAddressBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(Address address) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CurrentAddressBloc>()..add(CurrentAddressRequested()),
      child: BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
        builder: (context, state) {
          if (state is CurrentAddressSuccess) {
            return builder(state.address);
          }
          if (state is LocationServiceDisabled) {
            return const LocationServiceDisabledInfo();
          }
          return const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Đang lấy vị trí...',
            ),
          );
        },
      ),
    );
  }
}
