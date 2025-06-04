import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            children: [
              Text(
                'Thiết lập hồ sơ cá nhân',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Vui lòng hoàn tất thông tin để bắt đầu khám phá và chia sẻ trải nghiệm ẩm thực',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ảnh đại diện',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    AppTextField(
                      title: "Họ và tên",
                      hintText: "Nhập họ và tên của bạn",
                      showSupportingText: false,
                    ),
                    Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    AppTextField(
                      title: "Tên người dùng (username)",
                      hintText: "Nhập username",
                      showSupportingText: false,
                    ),
                    Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    AppTextField(
                      title: "Tiểu sử",
                      hintText: "Nhập tiểu sử",
                      showSupportingText: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  context.go("/home_page");
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcons.rocketFill.toSvg(
                          width: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Bắt đầu khám phá',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.showSupportingText,
  });

  final String title;
  final String hintText;
  final bool showSupportingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              if (showSupportingText)
                Row(
                  children: [
                    AppIcons.informationLine.toSvg(
                      width: 14,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'supporting text',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            maxLength: 10,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    )),
          ),
        ],
      ),
    );
  }
}
