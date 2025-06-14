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
  // 1. Quản lý FocusNode hoàn toàn tại Widget, không còn liên quan đến BLoC.
  // Thêm FocusNode cho tất cả các trường có thể được focus tự động.
  late final FocusNode _dishNameFocusNode;
  late final FocusNode _diningLocationNameFocusNode;

  @override
  void initState() {
    super.initState();
    _dishNameFocusNode = FocusNode();
    _diningLocationNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _dishNameFocusNode.dispose();
    _diningLocationNameFocusNode.dispose();
    super.dispose();
    getIt<ImageProcessor>().deleteTempImageFile(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 2. Cung cấp BLoC bằng service locator (getIt) thay vì khởi tạo trực tiếp.
      // Constructor của BLoC giờ không cần tham số.
      create: (context) => getIt<DiningInfoInputBloc>(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: appColorScheme(context).scrim.withValues(alpha: 0.5),
          overlayWidgetBuilder: (progress) => const CustomLoadingIndicator(
            indicatorSize: 40,
            indicatorText: 'Đang đăng tải bài viết...',
          ),
          // 3. Sử dụng MultiBlocListener để lắng nghe nhiều thay đổi trạng thái một cách rõ ràng.
          child: MultiBlocListener(
            listeners: [
              // Listener 1: Lắng nghe trạng thái submit form (giống như code cũ của bạn).
              BlocListener<DiningInfoInputBloc, DiningInfoInputState>(
                listenWhen: (previous, current) => previous.formzSubmissionStatus != current.formzSubmissionStatus,
                listener: (context, state) {
                  if (state.formzSubmissionStatus.isSuccess) {
                    context.loaderOverlay.hide();
                    // Hiển thị thông báo thành công nếu cần
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Đăng bài thành công!')));
                    context.pop();
                  }
                  if (state.formzSubmissionStatus.isInProgress) {
                    FocusScope.of(context).unfocus();
                    context.loaderOverlay.show();
                  }
                  if (state.formzSubmissionStatus.isFailure) {
                    context.loaderOverlay.hide();
                    // Hiển thị thông báo lỗi nếu cần
                    // ScaffoldMessenger.of(context)
                    //   ..hideCurrentSnackBar()
                    //   ..showSnackBar(const SnackBar(content: Text('Đã có lỗi xảy ra. Vui lòng thử lại.')));
                  }
                },
              ),
              // Listener 2: Lắng nghe yêu cầu focus từ BLoC.
              BlocListener<DiningInfoInputBloc, DiningInfoInputState>(
                listenWhen: (previous, current) => previous.fieldToFocus != current.fieldToFocus,
                listener: (context, state) {
                  if (state.fieldToFocus != null) {
                    switch (state.fieldToFocus!) {
                      case DiningInfoInputField.dishName:
                        _dishNameFocusNode.requestFocus();
                        break;
                      case DiningInfoInputField.diningLocationName:
                        _diningLocationNameFocusNode.requestFocus();
                        break;
                    }
                    // Báo cho BLoC biết UI đã xử lý yêu cầu focus.
                    context.read<DiningInfoInputBloc>().add(FocusRequestHandled());
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: Text('Bài đăng mới', style: Theme.of(context).textTheme.titleMedium),
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).colorScheme.surface,
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: AppIcons.left.toSvg(color: Theme.of(context).colorScheme.onSurface),
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.read<DiningInfoInputBloc>().add(DiningInfoInputSubmitted()),
                    child: const Text('Đăng'),
                  ),
                ],
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        children: [
                          Text(
                            '8:30 25/05/2025', // Cái này bạn có thể thay bằng dữ liệu động
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                          const SizedBox(height: 20),
                          RoundedSquareImage(imagePath: widget.imagePath),
                          const SizedBox(height: 20),
                          // 4. Sử dụng BlocBuilder để rebuild UI khi trạng thái input thay đổi
                          BlocBuilder<DiningInfoInputBloc, DiningInfoInputState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  AppTextField(
                                    // Gắn FocusNode của Widget vào đây
                                    focusNode: _dishNameFocusNode,
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    autoFocus: true,
                                    title: 'Tên món ăn*',
                                    hintText: 'Nhập tên món ăn...',
                                    maxLength: 100,
                                    onChanged: (dishName) => context.read<DiningInfoInputBloc>().add(DishNameInputChanged(dishName: dishName)),
                                    // Sử dụng `displayError` của Formz v0.7.0+ để code gọn hơn
                                    // Hoặc giữ logic cũ của bạn nếu muốn thông báo lỗi tùy chỉnh
                                    errorText: state.dishNameInput.isNotValid && !state.dishNameInput.isPure ? 'Tên món ăn không được để trống' : null,
                                  ),
                                  const SizedBox(height: 10),
                                  AppTextField(
                                    // Gắn FocusNode tương ứng
                                    focusNode: _diningLocationNameFocusNode,
                                    title: 'Tên quán ăn',
                                    hintText: 'Nhập tên quán ăn...',
                                    maxLength: 200,
                                    onChanged: (diningLocationName) => context.read<DiningInfoInputBloc>().add(DiningLocationNameInputChanged(diningLocationName: diningLocationName)),
                                    // Thêm errorText cho các trường khác để nhất quán
                                    errorText: state.diningLocationNameInput.isNotValid && !state.diningLocationNameInput.isPure ? 'Tên quán ăn không hợp lệ' : null,
                                  ),
                                  const SizedBox(height: 10),
                                  AppTextField(
                                    enabled: false,
                                    title: 'Địa chỉ',
                                    initialValue: widget.address.displayName,
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
          ),
        );
      }),
    );
  }
}
