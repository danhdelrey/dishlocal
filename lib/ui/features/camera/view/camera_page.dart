import 'package:camera/camera.dart';
import 'package:dishlocal/app/config/set_up_locators.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      locator<CameraDescription>(),
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    ImageProcessor.deleteTempImageFile(_imageFile);
    _controller.dispose();
    super.dispose();
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
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            final screenWidth = MediaQuery.of(context).size.width;

            final squareSize = screenWidth;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Widget để định nghĩa vùng vuông và crop
                  SizedBox(
                    width: squareSize,
                    height: squareSize, // Đảm bảo đây là hình vuông
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
                          width: _controller.value.previewSize!.height, // Thường là chiều rộng sau khi xoay
                          height: _controller.value.previewSize!.width, // Thường là chiều cao sau khi xoay
                          child: CameraPreview(_controller),
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
                      // Take the Picture in a try / catch block. If anything goes wrong,
                      // catch the error.
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;

                        // Attempt to take a picture and get the file `image`
                        // where it was saved.
                        _imageFile = await _controller.takePicture();
                        if (_imageFile != null) {
                          await ImageProcessor.cropSquare(_imageFile!.path, _imageFile!.path, false);
                        }
                        if (!context.mounted) return;

                        if (_imageFile != null) {
                          context.push('/new_post', extra: _imageFile!.path);
                        }
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        Logger().e(e);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ImageProcessor {
  static Future<String> cropSquare(String srcFilePath, String destFilePath, bool flip) async {
    var bytes = await File(srcFilePath).readAsBytes();
    img.Image src = img.decodeImage(bytes)!;

    var cropSize = min(src.width, src.height);
    int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
    int offsetY = (src.height - min(src.width, src.height)) ~/ 2;

    img.Image destImage = img.copyCrop(src, x: offsetX, y: offsetY, width: cropSize, height: cropSize);

    if (flip) {
      destImage = img.flipVertical(destImage);
    }

    var jpg = img.encodeJpg(destImage);
    await File(destFilePath).writeAsBytes(jpg);
    return destFilePath;
  }

  // Hàm chuyên để xóa file ảnh tạm
  static Future<void> deleteTempImageFile(XFile? imageFile) async {
    if (imageFile != null) {
      try {
        final file = File(imageFile.path);
        // Kiểm tra xem file có tồn tại không trước khi xóa
        if (await file.exists()) {
          await file.delete();
          Logger().i('Đã xóa file tạm: ${imageFile.path}');
        }
      } catch (e) {
        Logger().e('Lỗi khi xóa file: $e');
      }
    }
  }
}
