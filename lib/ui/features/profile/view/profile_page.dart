import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lanadelrey'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: AppIcons.userSettingLine.toSvg(
                color: Theme.of(context).colorScheme.onSurface,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CroppedImage(
                  borderRadius: 1000,
                  path: 'assets/images/Lana.jpg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đỗ Lan Anh',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: '125 N',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            children: [
                              TextSpan(
                                text: ' người theo dõi • ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                              ),
                            ],
                          ),
                          TextSpan(
                            text: '96',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            children: [
                              TextSpan(
                                text: ' đang theo dõi',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Follow mình để cùng "ăn sập" thế giới nhé! Mình là một người đam mê ẩm thực, luôn tìm kiếm những trải nghiệm mới lạ và độc đáo.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            
          ],
        ),
      ),
    );
  }
}
