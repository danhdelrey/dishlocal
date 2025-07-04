import 'dart:io';
import 'dart:math';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@lazySingleton
class ImageProcessor {
  final _log = Logger('ImageProcessor');
  Future<String> cropSquare(String srcFilePath, String destFilePath, bool flip) async {
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
  Future<void> deleteTempImageFile(String imagePath) async {
    try {
      final file = File(imagePath);
      // Kiểm tra xem file có tồn tại không trước khi xóa
      if (await file.exists()) {
        await file.delete();
        _log.info('Đã xóa file tạm: $imagePath');
      }
    } catch (e) {
      _log.severe('Lỗi khi xóa file: $e');
    }
  }

  String encodeImageToBlurhashString(String imagePath) {
    final data = File(imagePath).readAsBytesSync();
    final image = img.decodeImage(data);
    final blurHash = BlurHash.encode(image!, numCompX: 4, numCompY: 3);
    _log.info("Chuỗi blurhash của ảnh là: '${blurHash.hash}'");
    return blurHash.hash;
  }
}
