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
    // Lấy ID của người dùng hiện tại đang đăng nhập (người xem)
    final currentUserId = getIt<AppUserRepository>().getCurrentUserId();

    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
          // So sánh ID người xem với ID của người trên trang profile
          final isMyProfile = currentUserId == state.appUser.userId;

          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(25), // withValues deprecated
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CachedCircleAvatar(
                        circleRadius: 30,
                        imageUrl: state.appUser.photoUrl ?? '',
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        // Bọc trong Expanded để tránh tràn khi tên quá dài
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.appUser.displayName ?? state.appUser.originalDisplayname,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis, // Thêm để tránh tràn
                            ),
                            const SizedBox(height: 5),
                            CustomRichText(
                              label1: NumberFormatter.formatCompactNumberStable(state.appUser.followerCount),
                              description1: ' người theo dõi • ',
                              label2: NumberFormatter.formatCompactNumberStable(state.appUser.followingCount),
                              description2: ' đang theo dõi',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.appUser.bio != null && state.appUser.bio!.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      state.appUser.bio!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 20),

                  // THÊM ĐIỀU KIỆN Ở ĐÂY
                  // Chỉ hiển thị FollowButton nếu đây KHÔNG phải là trang của tôi
                  if (!isMyProfile)
                    FollowButton(
                      targetUser: state.appUser,
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
        // Hiển thị một placeholder loading đơn giản khi chưa có dữ liệu
        // để tránh màn hình trống trơn lúc đầu
        if (state is UserInfoLoading || state is UserInfoInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        // Trường hợp lỗi có thể hiển thị một thông báo
        if (state is UserInfoFailure) {
          return const Center(child: Text('Không thể tải thông tin người dùng.'));
        }

        return const SizedBox();
      },
    );
  }
}
