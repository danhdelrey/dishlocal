import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/gradient_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountSetupPage extends StatelessWidget {
  const AccountSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              const Column(
                children: [
                  AppTextField(
                    title: "Họ và tên",
                    hintText: "Nhập họ và tên của bạn",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                    title: "Tên người dùng (username)",
                    hintText: "Nhập username",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                    title: "Tiểu sử",
                    hintText: "Nhập tiểu sử",
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GradientFilledButton(
                icon: AppIcons.rocketFill.toSvg(
                  width: 16,
                  color: Colors.white,
                ),
                label: 'Bắt đầu khám phá',
                onTap: () {
                  context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
