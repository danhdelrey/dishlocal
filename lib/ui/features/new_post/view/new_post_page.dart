import 'dart:io';

import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/new_post/view/dining_location_info_input_section.dart';
import 'package:dishlocal/ui/features/new_post/view/food_info_input_section.dart';
import 'package:dishlocal/ui/features/new_post/view/rating_input_section.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image.dart';
import 'package:dishlocal/utils/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  void dispose() {
    
    super.dispose();

    getIt<ImageProcessor>().deleteTempImageFile(widget.imagePath);
  }

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
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '8:30 25/05/2025',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedSquareImage(imagePath: widget.imagePath),
                const SizedBox(
                  height: 20,
                ),
                const FoodInfoInputSection(),
                const SizedBox(
                  height: 20,
                ),
                const DiningLocationInfoInputSection(),
                const SizedBox(
                  height: 20,
                ),
                const RatingInputSection(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
