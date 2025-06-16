import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/view_post/view/reaction_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              _buildMainContent(context),
              // const Positioned(
              //   left: 0,
              //   right: 0,
              //   bottom: 0,
              //   child: CommentInput(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        GlassSliverAppBar(
          floating: true,
          pinned: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: AppIcons.left.toSvg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          title: const Text('Hamburger'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const BlurredEdgeWidget(
                        blurredChild: CachedImage(imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg'),
                        clearRadius: 1,
                        blurSigma: 100,
                        topChild: CachedImage(imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.location1.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: '1.2 km',
                      ),
                      Text(
                        'KFC Ninh Kiều',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        '75/36 Võ Trường Toản, phường An Hòa, quận Ninh Kiều, thành phố Cần Thơ, Việt Nam',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.wallet4.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: 'Giá: 50.000 đ',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GradientFilledButton(
                        maxWidth: true,
                        icon: AppIcons.location.toSvg(
                          width: 16,
                          color: Colors.white,
                        ),
                        label: 'Xem trên bản đồ',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const CachedCircleAvatar(
                            imageUrl: 'https://dep.com.vn/wp-content/uploads/2024/10/Lana.jpg',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'danhdelrey',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                CustomIconWithLabel(
                                  icon: AppIcons.locationCheckFilled.toSvg(
                                    color: Colors.blue,
                                    width: 14,
                                  ),
                                  labelStyle: appTextTheme(context).labelMedium!.copyWith(
                                        color: Colors.blue,
                                      ),
                                  label: '13:45 25/05/2025',
                                  labelColor: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: appColorScheme(context).primary,
                                borderRadius: BorderRadius.circular(12),
                                // border: BoxBorder.all(
                                //   color: appColorScheme(context).outline,
                                //   width: 1,
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Text(
                                  'Theo dõi',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: appColorScheme(context).onPrimary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        """🍔 [REVIEW] Trải nghiệm Hamburger tại KFC Ninh Kiều – Ăn một lần là nhớ mãi! 😋

Hôm nay thèm đồ ăn nhanh nên mình ghé KFC Ninh Kiều thử burger xem sao, ai ngờ lại bất ngờ vì ngon hơn mong đợi luôn!

📍 Vị trí: Quán nằm ngay trung tâm, dễ tìm, có không gian rộng rãi, sạch sẽ. Nhân viên phục vụ nhanh nhẹn và thân thiện.

🍔 Món mình gọi: Zinger Burger – lớp vỏ gà giòn rụm bên ngoài, thịt bên trong thì mềm và đậm vị, kết hợp cùng rau tươi và sốt cay nhẹ. Cắn một miếng là cảm giác "đã cái nư" liền 🤤

🥤 Combo kèm khoai tây chiên nóng hổi và Pepsi lạnh, ăn vào trời nóng thì đúng bài luôn!

💸 Giá cả: Tầm 40-80k/combo, khá hợp lý cho chất lượng và no căng bụng.

🌟 Đánh giá cá nhân:

Hương vị: 9/10

Không gian: 8.5/10

Phục vụ: 9/10

📌 Tips: Đi buổi trưa hơi đông chút nên nếu muốn ngồi chill lâu lâu thì đi sớm hoặc chiều muộn nhé!""",
                        style: appTextTheme(context).bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ReactionBar(),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
