import 'package:camera/camera.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/camera/bloc/camera_bloc.dart';
import 'package:dishlocal/ui/features/get_current_location/view/current_location_builder.dart';
import 'package:dishlocal/ui/features/internet_connection/view/internet_connection_handler.dart';
import 'package:dishlocal/ui/features/internet_connection/view/internet_disconnected.dart';
import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth;

    return BlocProvider(
      create: (context) => CameraBloc()..add(CameraInitialized()),
      child: LoaderOverlay(
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
          body: InternetConnectionHandler(
            initialChild: const Center(
              child: CustomLoadingIndicator(
                indicatorSize: 40,
                indicatorText: 'Đang kiểm tra kết nối...',
              ),
            ),
            childWhenConnected: CurrentLocationBuilder(
              builder: (position) {
                return BlocListener<CameraBloc, CameraState>(
                  listener: (context, state) {
                    if (state is CameraCaptureSuccess) {
                      context.push('/camera/new_post', extra: {
                        'imagePath': state.imagePath,
                        'currentPosition': position,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              'Vị trí hiện tại',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '75/36 Võ Trường Toản, phường An Hòa, quận Ninh Kiều, tp. Cần Thơ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CameraBloc, CameraState>(
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
                                    indicatorText: 'Đang khởi tạo máy ảnh...',
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
                                  indicatorText: 'Đang xử lý ảnh...',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      BlocBuilder<CameraBloc, CameraState>(
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
                      ),
                    ],
                  ),
                );
              },
            ),
            childWhenDisconnected: const InternetDisconnected(),
          ),
        ),
      ),
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
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
