import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/account_setup/bloc/account_setup_bloc.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/bio_input.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/display_name_input.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/username_input.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_avatar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logging/logging.dart';

class AccountSetupPage extends StatefulWidget {
  const AccountSetupPage({super.key});

  @override
  State<AccountSetupPage> createState() => _AccountSetupPageState();
}

class _AccountSetupPageState extends State<AccountSetupPage> {
  final _log = Logger('_AccountSetupPageState');

  late final FocusNode _displayNameFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _bioFocusNode;

  @override
  void initState() {
    _log.info('Khởi tạo các focus node của screen thiết lập tài khoản.');
    super.initState();
    _displayNameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _bioFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _log.info('Giải phóng các focus node của screen thiết lập tài khoản.');
    _displayNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _bioFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountSetupBloc>(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: appColorScheme(context).scrim.withValues(alpha: 0.5),
          overlayWidgetBuilder: (progress) => const CustomLoadingIndicator(
            indicatorSize: 40,
            indicatorText: 'Đang thiết lập tài khoản...',
          ),
          child: MultiBlocListener(
            listeners: [
              // Listener 1: Lắng nghe trạng thái submit form
              BlocListener<AccountSetupBloc, AccountSetupState>(
                listenWhen: (previous, current) => previous.formzSubmissionStatus != current.formzSubmissionStatus,
                listener: (context, state) {
                  // ===================================================================
                  // TRẠNG THÁI: ĐANG XỬ LÝ (inProgress)
                  // ===================================================================
                  if (state.formzSubmissionStatus.isInProgress) {
                    FocusScope.of(context).unfocus(); // Ẩn bàn phím
                    context.loaderOverlay.show(); // Hiển thị vòng quay loading
                  }
                  
                  // ===================================================================
                  // TRẠNG THÁI: THÀNH CÔNG (success)
                  // ===================================================================
                  else if (state.formzSubmissionStatus.isSuccess) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            'Thiết lập tài khoản thành công!',
                            style: appTextTheme(context).bodyMedium?.copyWith(color: appColorScheme(context).onInverseSurface),
                          ),
                          backgroundColor: appColorScheme(context).inverseSurface,
                        ),
                      );
                    // 🔥 KHÔNG CẦN GỌI EVENT NÀO Ở ĐÂY NỮA.
                    // AuthBloc sẽ tự động nhận được user mới và GoRouter sẽ tự động điều hướng.
                    // Trang này chỉ cần hiển thị thông báo thành công và chờ được điều hướng đi.
                  }

                  // ===================================================================
                  // TRẠNG THÁI: THẤT BẠI (failure)
                  // ===================================================================
                  else if (state.formzSubmissionStatus.isFailure) {
                    context.loaderOverlay.hide();
                    // Tận dụng errorMessage đã được thiết lập trong BLoC
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage!,
                              style: appTextTheme(context).bodyMedium?.copyWith(color: appColorScheme(context).onErrorContainer),
                            ),
                            backgroundColor: appColorScheme(context).errorContainer,
                          ),
                        );
                    }
                  }
                },

              ),
              // Listener 2: Lắng nghe yêu cầu focus từ BLoC
              BlocListener<AccountSetupBloc, AccountSetupState>(
                listenWhen: (previous, current) => previous.fieldToFocus != current.fieldToFocus,
                listener: (context, state) {
                  if (state.fieldToFocus != null) {
                    _log.fine('Nhận được yêu cầu focus vào trường: ${state.fieldToFocus}');
                    switch (state.fieldToFocus!) {
                      case AccountSetupField.displayName:
                        _displayNameFocusNode.requestFocus();
                        break;
                      case AccountSetupField.username:
                        _usernameFocusNode.requestFocus();
                        break;
                      case AccountSetupField.bio:
                        _bioFocusNode.requestFocus();
                        break;
                    }
                    // Báo cho BLoC biết UI đã xử lý yêu cầu focus
                    context.read<AccountSetupBloc>().add(FocusRequestHandled());
                  }
                },
              ),
            ],
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
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
                        const SizedBox(height: 10),
                        Text(
                          'Vui lòng hoàn tất thông tin để bắt đầu khám phá và chia sẻ trải nghiệm ẩm thực',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        const ProfileAvatar(avatarRadius: 40),
                        const SizedBox(height: 30),
                        // Sử dụng BlocBuilder để chỉ rebuild các trường input
                        BlocBuilder<AccountSetupBloc, AccountSetupState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                AppTextField(
                                  focusNode: _usernameFocusNode,
                                  title: "Username*",
                                  hintText: "VD: annguyen123",
                                  onChanged: (value) => context.read<AccountSetupBloc>().add(UsernameChanged(username: value)),
                                  errorText: state.usernameInput.isNotValid && !state.usernameInput.isPure ? state.usernameInput.displayError?.getMessage() : null,
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                  focusNode: _displayNameFocusNode,
                                  title: "Nickname*",
                                  hintText: "Nhập nickname của bạn...",
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) => context.read<AccountSetupBloc>().add(DisplayNameChanged(displayName: value)),
                                  errorText: state.displayNameInput.isNotValid && !state.displayNameInput.isPure ? state.displayNameInput.displayError?.getMessage() : null,
                                ),
                                const SizedBox(height: 10),
                                AppTextField(
                                  focusNode: _bioFocusNode,
                                  title: "Tiểu sử",
                                  hintText: "Giới thiệu ngắn về bạn...",
                                  minLine: 3,
                                  maxLine: 5,
                                  maxLength: 150,
                                  onChanged: (value) => context.read<AccountSetupBloc>().add(BioChanged(bio: value)),
                                  errorText: state.bioInput.isNotValid && !state.bioInput.isPure ? state.bioInput.displayError?.getMessage() : null,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        GradientFilledButton(
                          icon: AppIcons.rocketFill.toSvg(
                            width: 16,
                            color: Colors.white,
                          ),
                          label: 'Bắt đầu khám phá',
                          onTap: () {
                            // Gửi sự kiện submit đến BLoC
                            context.read<AccountSetupBloc>().add(AccountSetupSubmitted());
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
