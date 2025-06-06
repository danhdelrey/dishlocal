import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
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
                      width: 44,
                      height: 44,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                )
                              ],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              AppIcons.locationCheckFilled.toSvg(
                                width: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                '13:45 25/05/2025',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Colors.blue,
                                    ),
                              )
                            ],
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
                const ReviewSection(
                  category: 'Đồ ăn',
                  comment:
                      'Mới vừa ăn một dĩa cơm tấm ở Quán Hoàng Sang... Ôi trời ơi, ngon xỉu up xỉu down luôn mọi người ơi! 🤤 Miếng sườn nướng thấm vị, nước mắm đỉnh cao, ăn xong chỉ muốn order thêm dĩa nữa. Highly recommend cho team mê cơm tấm nha! ❤️',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ReviewSection(
                  category: 'Không gian',
                  comment:
                      'Quán tuy nhỏ, nằm trong hẻm nhưng rất sạch sẽ, gọn gàng từ khu vực bếp đến bàn ăn. Điều này làm tôi cảm thấy rất yên tâm khi thưởng thức.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ReviewSection(
                  category: 'Phục vụ',
                  comment:
                      'Cô chú chủ quán cực kỳ thân thiện, nhiệt tình, luôn nở nụ cười và hỏi han khách. Tạo cảm giác như đang ăn cơm nhà vậy, rất thoải mái.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ReviewSection(
                  category: 'Giá cả',
                  comment:
                      'Với chất lượng món ăn và dịch vụ nhận được, mức giá từ 45k-75k/phần là hoàn toàn hợp lý, thậm chí là rẻ cho một đĩa cơm tấm "đỉnh của chóp" như vậy ở khu vực trung tâm.',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Cơm tấm sườn bì chả',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return CroppedImage(
                      borderRadius: 12,
                      height: constraints.maxWidth,
                      path: 'assets/images/com-tam-suon-bi-cha-2.jpg');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.category,
    required this.comment,
  });

  final String category;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        Row(
          children: [
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Text(
              '10/10',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
        Text(
          comment,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
