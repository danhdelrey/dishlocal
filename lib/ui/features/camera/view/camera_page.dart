import 'package:camera/camera.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/camera/bloc/camera_bloc.dart';
import 'package:dishlocal/ui/features/current_address/view/current_address_builder.dart';
import 'package:dishlocal/ui/features/internet_connection/view/internet_connection_checker.dart';
import 'package:dishlocal/ui/features/internet_connection/view/internet_connection_disconnected_info.dart';
import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth;

    return LoaderOverlay(
      overlayColor: Colors.transparent,
      overlayWidgetBuilder: (progress) => const SizedBox(),
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
        ),
        body: InternetConnectionChecker(
          builder: (hasInternetAccess) {
            if (!hasInternetAccess) {
              return const InternetConnectionDisconnectedInfo();
            }
            return CurrentAddressBuilder(
              builder: (address) {
                return BlocProvider(
                  create: (context) => getIt<CameraBloc>()..add(CameraInitialized()),
                  child: BlocListener<CameraBloc, CameraState>(
                    listener: (context, state) {
                      if (state is CameraCaptureSuccess) {
                        context.pushReplacement('/camera/new_post', extra: {
                          'imagePath': state.imagePath,
                          'address': address,
                        });
                      }
                      if (state is CameraCaptureInProgress) {
                        context.loaderOverlay.show();
                      }
                      if (state is CameraCaptureSuccess) {
                        context.loaderOverlay.hide();
                      }
                    },
                    child: Column(
                      children: [
                        _buildHeader(context, address),
                        _buildCamera(squareSize),
                        const Spacer(),
                        _buildCameraCapture(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  BlocBuilder<CameraBloc, CameraState> _buildCameraCapture() {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraReady) {
          return GradientFab(
            size: 80,
            iconSize: 40,
            onTap: () async {
              context.read<CameraBloc>().add(CameraCaptureRequested());
            },
          );
        }
        return const GradientFab(
          size: 80,
          iconSize: 40,
        );
      },
    );
  }

  Padding _buildHeader(BuildContext context, Address address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        children: [
          AppIcons.location1.toSvg(
            color: appColorScheme(context).onSurface,
          ),
          Text(
            'Vị trí hiện tại',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            address.displayName,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BlocBuilder<CameraBloc, CameraState> _buildCamera(double squareSize) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraInitializationInProgress) {
          return SizedBox(
            width: squareSize,
            height: squareSize,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CustomLoadingIndicator(
                  indicatorSize: 40,
                ),
              ),
            ),
          );
        }
        if (state is CameraReady) {
          return _buildCameraPreview(
            squareSize: squareSize,
            context: context,
            cameraController: state.cameraController,
          );
        }
        if (state is CameraFailure) {
          return SizedBox(
            width: squareSize,
            height: squareSize,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning_amber_rounded),
                      Text(
                        'Không thể truy cập máy ảnh',
                        style: appTextTheme(context).titleMedium,
                      ),
                      Text(
                        'Vui lòng kiểm tra lại thiết bị hoặc quyền truy cập.',
                        style: appTextTheme(context).labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return SizedBox(
          width: squareSize,
          height: squareSize,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CustomLoadingIndicator(
                indicatorSize: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCameraPreview({
    required double squareSize,
    required BuildContext context,
    required CameraController cameraController,
  }) {
    return SizedBox(
      width: squareSize,
      height: squareSize, // Đảm bảo đây là hình vuông
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // Cắt những gì tràn ra ngoài SizedBox vuông
            child: FittedBox(
              fit: BoxFit.cover, // Lấp đầy và crop, giữ tỷ lệ
              child: SizedBox(
                // Kích thước này quan trọng để FittedBox biết
                // tỷ lệ gốc của CameraPreview.
                // CameraPreview tự nó sẽ cố gắng hiển thị đúng tỷ lệ của nó.
                // Nếu previewSize.width là chiều dài thực sự của preview
                // (có thể đã xoay), thì width/height của SizedBox này phải khớp.
                // Thông thường, CameraPreview là landscape, nên width > height.
                // Nếu camera.previewSize là (1920, 1080)
                // width: 1920, height: 1080 (hoặc ngược lại nếu đã xoay)
                // FittedBox sẽ dùng tỷ lệ này để scale.
                width: cameraController.value.previewSize!.height, // Thường là chiều rộng sau khi xoay
                height: cameraController.value.previewSize!.width, // Thường là chiều cao sau khi xoay
                child: CameraPreview(cameraController),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
