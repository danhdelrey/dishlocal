import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
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
    final currentUserId = getIt<AppUserRepository>().getCurrentUserId();

    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
          final isMyProfile = currentUserId == state.appUser.userId;

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Avatar
                  Center(
                    child: CachedCircleAvatar(
                      circleRadius: 40,
                      imageUrl: state.appUser.photoUrl ?? '',
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Display name
                  Center(
                    child: Text(
                      state.appUser.displayName ?? state.appUser.originalDisplayname ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberInformation(
                        context: context,
                        count: state.appUser.postCount,
                        label: 'Bài viết',
                      ),
                      _buildNumberInformation(
                        context: context,
                        count: state.appUser.likeCount,
                        label: 'Lượt thích',
                      ),
                      _buildNumberInformation(
                        context: context,
                        count: state.appUser.followerCount,
                        label: 'Followers',
                      ),
                      _buildNumberInformation(
                        context: context,
                        count: state.appUser.followingCount,
                        label: 'Following',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Bio
                  if (state.appUser.bio != null && state.appUser.bio!.trim().isNotEmpty)
                    Center(
                      child: Text(
                        'Tiểu sử:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: appColorScheme(context).outline,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (state.appUser.bio != null && state.appUser.bio!.trim().isNotEmpty)
                    Center(
                      child: Text(
                        state.appUser.bio!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20),
                  // Follow button (if not my profile)
                  if (!isMyProfile)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FollowButton(
                        targetUser: state.appUser,
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        if (state is UserInfoLoading || state is UserInfoInitial) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: CachedCircleAvatar(
                      circleRadius: 30,
                      imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg',
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      '???',
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: CustomRichText(
                      label1: '???',
                      description1: ' người theo dõi • ',
                      label2: '???',
                      description2: ' đang theo dõi',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      '',
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }

        if (state is UserInfoFailure) {
          return const Center(child: Text('Không thể tải thông tin người dùng.'));
        }

        return const SizedBox();
      },
    );
  }

  Column _buildNumberInformation({
    required BuildContext context,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          NumberFormatter.formatCompactNumberStable(count),
          style: appTextTheme(context).labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(label,
            style: appTextTheme(context).labelSmall?.copyWith(
                  color: appColorScheme(context).outline,
                )),
      ],
    );
  }
}
