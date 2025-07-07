import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/create_post/bloc/create_post_bloc.dart';
import 'package:dishlocal/ui/features/create_post/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/dish_name_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/exact_address_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/money_input.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:dishlocal/ui/features/select_food_category/view/expandable_chip_selector.dart';
import 'package:dishlocal/ui/features/select_food_category/view/food_category_builder.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/image_widgets/rounded_corner_image_file.dart';
import 'package:dishlocal/core/utils/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logging/logging.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage.create({super.key, required this.imagePath, required this.address, required this.blurHash})
      : postToUpdate = null,
        inEditMode = false;

  const NewPostPage.edit({
    super.key,
    required this.postToUpdate,
  })  : inEditMode = true,
        imagePath = '',
        blurHash = '',
        address = const Address(latitude: 1, longitude: 1);

  final Post? postToUpdate;
  final String imagePath;
  final String blurHash;
  final Address address;

  final bool inEditMode;

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
      create: (context) {
        if (widget.inEditMode) {
          return getIt<CreatePostBloc>()..add(CreatePostInitialized(postToUpdate: widget.postToUpdate));
        } else {
          return getIt<CreatePostBloc>()..add(const CreatePostInitialized());
        }
      },
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
              BlocListener<CreatePostBloc, CreatePostState>(
                // listenWhen rất tốt, giữ nguyên nó để tối ưu hóa.
                listenWhen: (previous, current) => previous.formzSubmissionStatus != current.formzSubmissionStatus,
                listener: (context, state) {
                  _log.info('🎧 BlocListener nhận được trạng thái submit mới: ${state.formzSubmissionStatus}');

                  // --- KHI BẮT ĐẦU SUBMIT ---
                  if (state.formzSubmissionStatus.isInProgress) {
                    _log.info('⏳ Trạng thái: InProgress. Đang ẩn bàn phím và hiển thị loading...');
                    // Ẩn bàn phím để người dùng không thể nhập thêm khi đang xử lý.
                    FocusScope.of(context).unfocus();
                    context.loaderOverlay.show();
                  }

                  // --- KHI SUBMIT THẤT BẠI ---
                  if (state.formzSubmissionStatus.isFailure) {
                    _log.warning('💥 Trạng thái: Failure. Đang ẩn loading và hiển thị SnackBar lỗi.');
                    context.loaderOverlay.hide();

                    // [TỐI ƯU HÓA] Ưu tiên hiển thị lỗi cụ thể từ BLoC nếu có.
                    final errorMessage = state.errorMessage;
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red[800], // Thêm màu để nhấn mạnh lỗi
                          ),
                        );
                    }
                  }

                  // --- KHI SUBMIT THÀNH CÔNG ---
                  if (state.formzSubmissionStatus.isSuccess) {
                    _log.info('🎉 Trạng thái: Success. Đang ẩn loading, hiển thị thông báo và điều hướng.');
                    context.loaderOverlay.hide();

                    final successMessage = widget.inEditMode ? 'Đã chỉnh sửa thành công!' : 'Đăng bài thành công!';

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(successMessage),
                          backgroundColor: Colors.green[700], // Thêm màu cho thông báo thành công
                        ),
                      );

                    // context.pop(true) để báo cho màn hình trước đó rằng có sự thay đổi.
                    context.pop(true);
                  }
                },
              ),
              // Listener 2: Lắng nghe yêu cầu focus từ BLoC.
              BlocListener<CreatePostBloc, CreatePostState>(
                listenWhen: (previous, current) => previous.fieldToFocus != current.fieldToFocus,
                listener: (context, state) {
                  if (state.fieldToFocus != null) {
                    switch (state.fieldToFocus!) {
                      case CreatePostInputField.dishName:
                        _dishNameFocusNode.requestFocus();
                        break;
                      case CreatePostInputField.moneyInput:
                        _moneyInputFocusNode.requestFocus();
                        break;
                      case CreatePostInputField.diningLocationName:
                        _diningLocationNameFocusNode.requestFocus();
                        break;
                      case CreatePostInputField.exactAddress:
                        _exactAddressInputFocusNode.requestFocus();
                        break;
                      case CreatePostInputField.insightInput:
                        _insightInputFocusNode.requestFocus();
                        break;
                    }
                    // Báo cho BLoC biết UI đã xử lý yêu cầu focus.
                    context.read<CreatePostBloc>().add(FocusRequestHandled());
                  }
                },
              ),
            ],
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: FoodCategoryBuilder(
                    initialFoodCategory: widget.postToUpdate?.foodCategory != null ? {widget.postToUpdate!.foodCategory!} : {},
                    builder: (
                      context,
                      allCategories,
                      selectedCategories,
                      allowMultiSelect,
                    ) {
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        slivers: [
                          GlassSliverAppBar(
                            title: Text(widget.inEditMode ? 'Chỉnh sửa bài đăng' : 'Bài đăng mới'),
                            centerTitle: true,
                            pinned: true,
                            floating: true,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Logger('NewPostPage').info('food category selected: $selectedCategories');
                                  context.read<CreatePostBloc>().add(
                                        CreatePostRequested(
                                          address: widget.address,
                                          imagePath: widget.imagePath,
                                          createdAt: now,
                                          blurHash: widget.blurHash,
                                          foodCategory: selectedCategories.isNotEmpty ? selectedCategories.first : null,
                                          postToUpdate: widget.inEditMode ? widget.postToUpdate : null,
                                        ),
                                      );
                                },
                                child: Text(widget.inEditMode ? 'Cập nhật' : 'Đăng bài'),
                              ),
                            ],
                            leading: IconButton(
                              onPressed: () => context.pop(),
                              icon: AppIcons.left.toSvg(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  widget.inEditMode ? TimeFormatter.formatDateTimeFull(widget.postToUpdate?.createdAt ?? now) : formatted,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: Text(
                                    widget.inEditMode ? (widget.postToUpdate?.address?.displayName ?? '') : (widget.address.displayName ?? ''),
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                widget.inEditMode ? CachedImage(borderRadius: 30, blurHash: widget.postToUpdate?.blurHash ?? '', imageUrl: widget.postToUpdate?.imageUrl ?? '') : RoundedCornerImageFile(borderRadius: 30, imagePath: widget.imagePath),
                                const SizedBox(height: 20),
                                // 4. Sử dụng BlocBuilder để rebuild UI khi trạng thái input thay đổi
                                BlocBuilder<CreatePostBloc, CreatePostState>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        children: [
                                          ExpandableChipSelector(
                                            title: '📋 Chọn loại món',
                                            items: allCategories,
                                            allowMultiSelect: allowMultiSelect,
                                            selectedItems: selectedCategories,
                                            onCategoryTapped: (category) {
                                              context.read<SelectFoodCategoryBloc>().add(SelectFoodCategoryEvent.categoryToggled(category));
                                            },
                                            onSelectAllTapped: () {
                                              context.read<SelectFoodCategoryBloc>().add(const SelectFoodCategoryEvent.allToggled());
                                            },
                                            selectAllText: '📋 Tất cả',
                                            selectAllColor: Colors.indigo,
                                          ),
                                          const SizedBox(height: 20),
                                          AppTextField(
                                            initialValue: widget.inEditMode ? widget.postToUpdate?.dishName : null,
                                            focusNode: _dishNameFocusNode,
                                            keyboardType: TextInputType.name,
                                            maxLine: 1,
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            autoFocus: true,
                                            title: 'Tên món ăn*',
                                            hintText: 'Nhập tên món ăn...',
                                            maxLength: 100,
                                            onChanged: (dishName) => context.read<CreatePostBloc>().add(DishNameInputChanged(dishName: dishName)),
                                            // Sử dụng `displayError` của Formz v0.7.0+ để code gọn hơn
                                            // Hoặc giữ logic cũ của bạn nếu muốn thông báo lỗi tùy chỉnh
                                            errorText: state.dishNameInput.isNotValid && !state.dishNameInput.isPure ? state.dishNameInput.displayError?.getMessage() : null,
                                          ),
                                          const SizedBox(height: 10),
                                          AppTextField(
                                            initialValue: widget.inEditMode ? NumberFormatter.formatMoney(widget.postToUpdate?.price ?? 0) : null,
                                            leadingIcon: AppIcons.wallet4.toSvg(
                                              width: 16,
                                              color: appColorScheme(context).onSurface,
                                            ),
                                            inputFormatters: [
                                              CurrencyInputFormatter(
                                                trailingSymbol: 'đ',
                                                mantissaLength: 0,
                                                thousandSeparator: ThousandSeparator.Period,
                                                useSymbolPadding: true,
                                              ),
                                            ],
                                            focusNode: _moneyInputFocusNode,
                                            keyboardType: TextInputType.number,
                                            title: 'Giá tiền*',
                                            hintText: 'Nhập giá tiền của món ăn...',
                                            maxLine: 1,
                                            maxLength: 12,
                                            onChanged: (money) {
                                              context.read<CreatePostBloc>().add(MoneyInputChanged(money: money));
                                            },
                                            errorText: state.moneyInput.isNotValid && !state.moneyInput.isPure ? state.moneyInput.displayError?.getMessage() : null,
                                          ),
                                          const SizedBox(height: 10),
                                          AppTextField(
                                            initialValue: widget.inEditMode ? widget.postToUpdate?.diningLocationName : null,
                                            focusNode: _diningLocationNameFocusNode,
                                            keyboardType: TextInputType.name,
                                            maxLine: 1,
                                            title: 'Tên quán ăn*',
                                            hintText: 'Nhập tên quán ăn...',
                                            maxLength: 200,
                                            onChanged: (diningLocationName) => context.read<CreatePostBloc>().add(DiningLocationNameInputChanged(diningLocationName: diningLocationName)),
                                            // Thêm errorText cho các trường khác để nhất quán
                                            errorText: state.diningLocationNameInput.isNotValid && !state.diningLocationNameInput.isPure ? state.diningLocationNameInput.displayError?.getMessage() : null,
                                          ),
                                          const SizedBox(height: 10),
                                          AppTextField(
                                            initialValue: widget.inEditMode ? widget.postToUpdate?.address?.exactAddress : null,
                                            focusNode: _exactAddressInputFocusNode,
                                            title: 'Địa chỉ cụ thể của quán ăn',
                                            keyboardType: TextInputType.name,
                                            maxLine: 1,
                                            hintText: 'Vd: số nhà, tên đường, nhận biết...',
                                            maxLength: 200,
                                            onChanged: (exactAddress) => context.read<CreatePostBloc>().add(ExactAddressInputChanged(exactAddress: exactAddress)),
                                            errorText: state.exactAddressInput.isNotValid && !state.exactAddressInput.isPure ? state.exactAddressInput.displayError?.getMessage() : null,
                                          ),
                                          const SizedBox(height: 10),
                                          AppTextField(
                                            initialValue: widget.inEditMode ? widget.postToUpdate?.insight : null,
                                            focusNode: _insightInputFocusNode,
                                            title: 'Cảm nhận',
                                            hintText: 'Nêu cảm nhận của bạn...',
                                            maxLength: 2000,
                                            minLine: 10,
                                            maxLine: 1000,
                                            onChanged: (insight) => context.read<CreatePostBloc>().add(InsightInputChanged(insight: insight)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
