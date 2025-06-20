import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avatarRadius,
  });

  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserInfoBloc>()..add(const UserInfoRequested()),
      child: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoSuccess) {
            return CachedCircleAvatar(
              imageUrl: state.appUser.photoUrl ?? '',
              circleRadius: avatarRadius,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
