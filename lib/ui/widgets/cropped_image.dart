import 'package:flutter/material.dart';

class CroppedImage extends StatelessWidget {
  const CroppedImage({
    super.key,
    required this.borderRadius,
    this.width,
    this.height,
    required this.path,
  });

  final String path;
  final double borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // Bo tròn góc
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          path, // Thay bằng đường dẫn ảnh của bạn
          fit: BoxFit
              .cover, // Đảm bảo ảnh lấp đầy khung hình và cắt bỏ phần thừa
        ),
      ),
    );
  }
}
