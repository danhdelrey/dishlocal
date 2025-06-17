import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/profile_avatar/bloc/profile_avatar_bloc.dart';
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
      create: (context) => getIt<ProfileAvatarBloc>()..add(ProfileAvatarFetched()),
      child: BlocBuilder<ProfileAvatarBloc, ProfileAvatarState>(
        builder: (context, state) {
          if (state is ProfileAvatarSuccess) {
            return CachedCircleAvatar(
              imageUrl: state.imageUrl,
              circleRadius: avatarRadius,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
