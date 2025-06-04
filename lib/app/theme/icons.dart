// Đường dẫn cơ sở tới thư mục icons
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _baseIconPath = 'assets/icons/';

enum AppIcons {
  appIcon('app-icon');

  const AppIcons(this.fileName);
  final String fileName;

  String get path => '$_baseIconPath$fileName.svg';


  Widget toSvg({
    double? width,
    double? height,
    Color? color, // Dùng để tint màu cho SVG (nếu SVG hỗ trợ)
    BoxFit fit = BoxFit.contain,
    String? semanticsLabel, // Để hỗ trợ accessibility
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit,
      semanticsLabel: semanticsLabel ??
          '${fileName.replaceAll('-', ' ')} icon', // Tạo label mặc định
    );
  }
}
