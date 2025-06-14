import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/view_post/view/review_section.dart';
import 'package:dishlocal/ui/widgets/blurred_edge_image.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:dishlocal/ui/widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image_asset.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _buildMainContent(context),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CommentInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: AppIcons.left.toSvg(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const CroppedImage(
                  borderRadius: 1000,
                  path: 'assets/images/Lana.jpg',
                  width: 36,
                  height: 36,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'lanadelrey',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: ' • Theo dõi',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            )
                          ],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.locationCheckFilled.toSvg(
                          color: Colors.blue,
                          width: 16,
                        ),
                        label: '13:45 25/05/2025',
                        labelColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ReviewSection(
                    category: 'Đồ ăn:',
                    comment: 'Mới vừa ăn một dĩa cơm tấm ở Quán Hoàng Sang... Ôi trời ơi, ngon xỉu up xỉu down luôn mọi người ơi! 🤤 Miếng sườn nướng thấm vị, nước mắm đỉnh cao, ăn xong chỉ muốn order thêm dĩa nữa. Highly recommend cho team mê cơm tấm nha! ❤️',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ReviewSection(
                    category: 'Không gian:',
                    comment: 'Quán tuy nhỏ, nằm trong hẻm nhưng rất sạch sẽ, gọn gàng từ khu vực bếp đến bàn ăn. Điều này làm tôi cảm thấy rất yên tâm khi thưởng thức.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ReviewSection(
                    category: 'Phục vụ:',
                    comment: 'Cô chú chủ quán cực kỳ thân thiện, nhiệt tình, luôn nở nụ cười và hỏi han khách. Tạo cảm giác như đang ăn cơm nhà vậy, rất thoải mái.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ReviewSection(
                    category: 'Giá cả:',
                    comment: 'Với chất lượng món ăn và dịch vụ nhận được, mức giá từ 45k-75k/phần là hoàn toàn hợp lý, thậm chí là rẻ cho một đĩa cơm tấm "đỉnh của chóp" như vậy ở khu vực trung tâm.',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Cơm tấm sườn bì chả',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AspectRatio(
                    aspectRatio: 1,
                    child: BlurredEdgeImage(
                      clearRadius: 0.7,
                      imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg',
                      blurSigma: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.location.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '2 km',
                  ),
                  Text(
                    'Cơm tấm Hoàng Sang',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    '75/36 Võ Trường Toản, phường An Hòa, quận Ninh Kiều, tp. Cần Thơ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.time.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: 'Giờ mở cửa: Từ 8:00 đến 23:00',
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.wallet4.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: 'Giá: 100.000đ',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.locationCheckFilled.toSvg(
                      color: Colors.blue,
                      width: 16,
                    ),
                    label: 'Bạn đã đến đây vào ngày 01/06/2025 lúc 10:23',
                    labelColor: Colors.blue,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconWithLabel(
                        icon: AppIcons.heart1.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        label: '12.4 N',
                        labelColor: Theme.of(context).colorScheme.outline,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.comment2.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        labelColor: Theme.of(context).colorScheme.outline,
                        label: '345',
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.locationCheck.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        labelColor: Theme.of(context).colorScheme.outline,
                        label: '345',
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.bookmark1.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        labelColor: Theme.of(context).colorScheme.outline,
                        label: '1.567',
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.shareForward.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        labelColor: Theme.of(context).colorScheme.outline,
                        label: '101',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const CommentSection(),
          ],
        ),
      ),
    );
  }
}
