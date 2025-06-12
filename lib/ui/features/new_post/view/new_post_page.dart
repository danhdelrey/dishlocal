import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/bloc/dining_info_input_bloc.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image.dart';
import 'package:dishlocal/utils/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key, required this.imagePath, required this.address});

  final String imagePath;
  final Address address;

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
    return BlocProvider(
      create: (_) => DiningInfoInputBloc(),
      child: Scaffold(
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
              onPressed: () {
                // if (context.canPop()) {
                //   context.pop();
                //   if (context.canPop()) {
                //     context.pop();
                //   }
                // }
                context.read<DiningInfoInputBloc>().add(DiningInfoInputSubmitted());
              },
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
                    '8:30 25/05/2025 ${widget.address.displayName}',
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
                  BlocBuilder<DiningInfoInputBloc, DiningInfoInputState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          AppTextField(
                            title: 'Tên món ăn*',
                            hintText: 'Nhập tên món ăn...',
                            maxLength: 100,
                            backgroundColor: appColorScheme(context).surfaceContainerLow,
                            onChanged: (dishName) => context.read<DiningInfoInputBloc>().add(DishNameInputChanged(dishName: dishName)),
                            errorText: state.dishNameInput.isPure
                                ? null
                                : state.dishNameInput.isValid
                                    ? null
                                    : 'Tên món ăn không được để trống',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
