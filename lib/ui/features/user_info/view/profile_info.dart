import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/ui/features/follow/view/follow_button.dart';
import 'package:dishlocal/ui/features/user_info/view/custom_rich_text.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CachedCircleAvatar(
                        circleRadius: 30,
                        imageUrl: state.appUser.photoUrl ?? '',
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.appUser.displayName ?? state.appUser.originalDisplayname,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomRichText(
                            label1: NumberFormatter.formatCompactNumberStable(state.appUser.followerCount),
                            description1: ' người theo dõi • ',
                            label2: NumberFormatter.formatCompactNumberStable(state.appUser.followingCount),
                            description2: ' đang theo dõi',
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (state.appUser.bio != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (state.appUser.bio != null)
                    Text(
                      state.appUser.bio!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  FollowButton(
                    targetUser: state.appUser,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
