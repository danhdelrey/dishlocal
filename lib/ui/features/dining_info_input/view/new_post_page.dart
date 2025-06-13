import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/bloc/dining_info_input_bloc.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image.dart';
import 'package:dishlocal/utils/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key, required this.imagePath, required this.address});

  final String imagePath;
  final Address address;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  late final FocusNode _dishNameFocusNode;

  @override
  void initState() {
    _dishNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _dishNameFocusNode.dispose();

    super.dispose();

    getIt<ImageProcessor>().deleteTempImageFile(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiningInfoInputBloc(
        dishNameFocusNode: _dishNameFocusNode,
      ),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: appColorScheme(context).scrim.withValues(alpha: 0.5),
          overlayWidgetBuilder: (progress) => const CustomLoadingIndicator(
            indicatorSize: 40,
            indicatorText: 'Đang đăng tải bài viết...',
          ),
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
                    context.read<DiningInfoInputBloc>().add(DiningInfoInputSubmitted());
                  },
                  child: const Text(
                    'Đăng',
                  ),
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        BlocConsumer<DiningInfoInputBloc, DiningInfoInputState>(
                          listener: (context, state) {
                            if (state.formzSubmissionStatus == FormzSubmissionStatus.success) {
                              context.loaderOverlay.hide();
                              context.pop();
                            }
                            if (state.formzSubmissionStatus == FormzSubmissionStatus.inProgress) {
                              FocusScope.of(context).unfocus();
                              context.loaderOverlay.show();
                            }
                            if (state.formzSubmissionStatus == FormzSubmissionStatus.failure) {
                              context.loaderOverlay.hide();
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              children: [
                                AppTextField(
                                  focusNode: state.dishNameFocusNode,
                                  autoFocus: true,
                                  title: 'Tên món ăn',
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
                                const SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  title: 'Tên quán ăn',
                                  hintText: 'Nhập tên quán ăn...',
                                  maxLength: 200,
                                  backgroundColor: appColorScheme(context).surfaceContainerLow,
                                  onChanged: (diningLocationName) => context.read<DiningInfoInputBloc>().add(DiningLocationNameInputChanged(diningLocationName: diningLocationName)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  enabled: false,
                                  title: 'Địa chỉ',
                                  initialValue: widget.address.displayName,
                                  backgroundColor: appColorScheme(context).surfaceContainerLow,
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
          ),
        );
      }),
    );
  }
}
