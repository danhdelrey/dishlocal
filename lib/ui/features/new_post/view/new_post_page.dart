import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/max_width_with_height_constraint_cropped_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bài đăng mới',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: AppIcons.left.toSvg(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Đăng',
              //style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Text(
            '8:30 25/05/2025',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const MaxWidthWithHeightConstraintCroppedImage(
            imagePath: 'assets/images/com-tam-suon-bi-cha-2.jpg',
          ),
          Text(
            'Thông tin món ăn',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const AppTextField(
            title: 'Tên món ăn*',
            hintText: 'Nhập tên món ăn...',
            showSupportingText: false,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppTextField(
            title: 'Tên món ăn*',
            hintText: 'Nhập tên món ăn...',
            showSupportingText: false,
          ),
        ],
      ),
    );
  }
}
