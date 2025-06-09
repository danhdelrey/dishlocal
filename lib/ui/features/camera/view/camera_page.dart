import 'package:camera/camera.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/camera/bloc/camera_bloc.dart';
import 'package:dishlocal/ui/widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth;

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
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is CameraCaptureSuccess) {
            context.push('/camera/new_post', extra: state.imagePath);
          }
        },
        builder: (context, state) {
          return switch (state) {
            CameraInitial() => const CircularProgressIndicator(),
            CameraInitializationInProgress() => const CircularProgressIndicator(),
            CameraReady(cameraController: final cameraController) => _buildCameraPreview(
                squareSize: squareSize,
                context: context,
                cameraController: cameraController,
              ),
            CameraFailure(failureMessage: final failureMessage) => Text(failureMessage),
            CameraCaptureInProgress() => const CircularProgressIndicator(),
            CameraCaptureSuccess() => const SizedBox(),
            CameraCaptureFailure(failureMessage: final failureMessage) => Text(failureMessage),
          };
        },
      ),
    );
  }

  Column _buildCameraPreview({
    required double squareSize,
    required BuildContext context,
    required CameraController cameraController,
  }) {
    return Column(
      children: [
        // Widget để định nghĩa vùng vuông và crop
        SizedBox(
          width: squareSize,
          height: squareSize, // Đảm bảo đây là hình vuông
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
        const SizedBox(
          height: 20,
        ),
        Text(
          'Hãy đưa đồ ăn vào khung hình',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const Spacer(),
        GradientFab(
          size: 80,
          icon: const Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.white,
          ),
          onTap: () async {
            context.read<CameraBloc>().add(CameraCaptureRequested());
          },
        ),
      ],
    );
  }
}
