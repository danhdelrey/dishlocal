import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/bloc/dining_info_input_bloc.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/exact_address_input.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/image_widgets/rounded_corner_image_file.dart';
import 'package:dishlocal/utils/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logging/logging.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key, required this.imagePath, required this.address});

  final String imagePath;
  final Address address;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _log = Logger('_NewPostPageState');

  late final FocusNode _dishNameFocusNode;
  late final FocusNode _diningLocationNameFocusNode;
  late final FocusNode _exactAddressInputFocusNode;
  late final FocusNode _insightInputFocusNode;
  late final FocusNode _moneyInputFocusNode;

  @override
  void initState() {
    _log.info('Khởi tạo các focus node của screen bài đăng mới');
    super.initState();
    _dishNameFocusNode = FocusNode();
    _diningLocationNameFocusNode = FocusNode();
    _exactAddressInputFocusNode = FocusNode();
    _insightInputFocusNode = FocusNode();
    _moneyInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _log.info('Giải phóng các focus node của screen bài đăng mới');
    _dishNameFocusNode.dispose();
    _diningLocationNameFocusNode.dispose();
    _exactAddressInputFocusNode.dispose();
    _insightInputFocusNode.dispose();
    _moneyInputFocusNode.dispose();
    super.dispose();
    getIt<ImageProcessor>().deleteTempImageFile(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatted = DateFormat('H:mm dd/MM/yyyy').format(now);

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
                      case DiningInfoInputField.exactAddress:
                        _exactAddressInputFocusNode.requestFocus();
                        break;
                      case DiningInfoInputField.insightInput:
                        _insightInputFocusNode.requestFocus();
                        break;
                      case DiningInfoInputField.moneyInput:
                        _moneyInputFocusNode.requestFocus();
                        break;
                    }
                    // Báo cho BLoC biết UI đã xử lý yêu cầu focus.
                    context.read<DiningInfoInputBloc>().add(FocusRequestHandled());
                  }
                },
              ),
            ],
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    GlassSliverAppBar(
                      title: const Text('Bài đăng mới'),
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      actions: [
                        TextButton(
                          onPressed: () => context.read<DiningInfoInputBloc>().add(DiningInfoInputSubmitted()),
                          child: const Text('Đăng'),
                        ),
                      ],
                      leading: IconButton(
                        onPressed: () => context.pop(),
                        icon: AppIcons.left.toSvg(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            BlurredEdgeWidget(
                              blurSigma: 100,
                              clearRadius: 1,
                              blurredChild: RoundedCornerImageFile(imagePath: widget.imagePath),
                              topChild: RoundedCornerImageFile(imagePath: widget.imagePath),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              formatted,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                widget.address.displayName,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // 4. Sử dụng BlocBuilder để rebuild UI khi trạng thái input thay đổi
                            BlocBuilder<DiningInfoInputBloc, DiningInfoInputState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    AppTextField(
                                      // Gắn FocusNode của Widget vào đây
                                      focusNode: _dishNameFocusNode,
                                      keyboardType: TextInputType.name,
                                      maxLine: 1,
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      autoFocus: true,
                                      title: 'Tên món ăn*',
                                      hintText: 'Nhập tên món ăn...',
                                      maxLength: 100,
                                      onChanged: (dishName) => context.read<DiningInfoInputBloc>().add(DishNameInputChanged(dishName: dishName)),
                                      // Sử dụng `displayError` của Formz v0.7.0+ để code gọn hơn
                                      // Hoặc giữ logic cũ của bạn nếu muốn thông báo lỗi tùy chỉnh
                                      errorText: state.dishNameInput.isNotValid && !state.dishNameInput.isPure ? state.dishNameInput.displayError?.getMessage() : null,
                                    ),
                                    const SizedBox(height: 10),
                                    AppTextField(
                                      focusNode: _moneyInputFocusNode,
                                      keyboardType: TextInputType.number,
                                      title: 'Giá*',
                                      hintText: 'Nhập giá của món ăn...',
                                      maxLength: 9,
                                      maxLine: 1,
                                      onChanged: (money) => context.read<DiningInfoInputBloc>().add(MoneyInputChanged(money: money)),
                                    ),
                                    const SizedBox(height: 10),
                                    AppTextField(
                                      // Gắn FocusNode tương ứng
                                      focusNode: _diningLocationNameFocusNode,
                                      keyboardType: TextInputType.name,
                                      maxLine: 1,
                                      title: 'Tên quán ăn*',
                                      hintText: 'Nhập tên quán ăn...',
                                      maxLength: 200,
                                      onChanged: (diningLocationName) => context.read<DiningInfoInputBloc>().add(DiningLocationNameInputChanged(diningLocationName: diningLocationName)),
                                      // Thêm errorText cho các trường khác để nhất quán
                                      errorText: state.diningLocationNameInput.isNotValid && !state.diningLocationNameInput.isPure ? state.diningLocationNameInput.displayError?.getMessage() : null,
                                    ),
                                    const SizedBox(height: 10),
                                    AppTextField(
                                      focusNode: _exactAddressInputFocusNode,
                                      title: 'Địa chỉ cụ thể của quán ăn',
                                      keyboardType: TextInputType.name,
                                      maxLine: 1,
                                      hintText: 'Vd: số nhà, tên đường, nhận biết...',
                                      maxLength: 200,
                                      onChanged: (exactAddress) => context.read<DiningInfoInputBloc>().add(ExactAddressInputChanged(exactAddress: exactAddress)),
                                      errorText: state.exactAddressInput.isNotValid && !state.exactAddressInput.isPure ? state.exactAddressInput.displayError?.getMessage() : null,
                                    ),
                                    const SizedBox(height: 10),
                                    AppTextField(
                                      focusNode: _insightInputFocusNode,
                                      title: 'Cảm nhận',
                                      hintText: 'Nêu cảm nhận của bạn...',
                                      maxLength: 2000,
                                      minLine: 10,
                                      maxLine: 1000,
                                      onChanged: (insight) => context.read<DiningInfoInputBloc>().add(InsightInputChanged(insight: insight)),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
