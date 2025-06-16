// Đường dẫn cơ sở tới thư mục icons
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _baseIconPath = 'assets/icons/';

enum AppIcons {
  bookmark('Bookmark-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Bookmark-Fill--Streamline-Mingcute-Fill.svg.svg
  bookmark1('Bookmark-Line--Streamline-Mingcute.svg'), // Gốc: Bookmark-Line--Streamline-Mingcute.svg.svg
  camera('Camera Streamline Heroicons Outline'), // Gốc: Camera Streamline Heroicons Outline.svg
  chat3('Chat-3-Line--Streamline-Mingcute.svg'), // Gốc: Chat-3-Line--Streamline-Mingcute.svg.svg
  checkCircle('Check-Circle-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Check-Circle-Fill--Streamline-Mingcute-Fill.svg.svg
  checkCircle1('Check-Circle-Line--Streamline-Mingcute.svg'), // Gốc: Check-Circle-Line--Streamline-Mingcute.svg.svg
  comment2('Comment-2-Line--Streamline-Mingcute.svg'), // Gốc: Comment-2-Line--Streamline-Mingcute.svg.svg
  eraserLine('Eraser Line Streamline Mingcute Line'), // Gốc: Eraser Line Streamline Mingcute Line.svg
  flag4Line('Flag 4 Line Streamline Mingcute Line'), // Gốc: Flag 4 Line Streamline Mingcute Line.svg
  heart('Heart-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Heart-Fill--Streamline-Mingcute-Fill.svg.svg
  heart1('Heart-Line--Streamline-Mingcute.svg'), // Gốc: Heart-Line--Streamline-Mingcute.svg.svg
  history('History-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: History-Fill--Streamline-Mingcute-Fill.svg.svg
  history1('History-Line--Streamline-Mingcute.svg'), // Gốc: History-Line--Streamline-Mingcute.svg.svg
  home2Line('Home 2 Line Streamline Mingcute Line'), // Gốc: Home 2 Line Streamline Mingcute Line.svg
  home4('Home-4-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Home-4-Fill--Streamline-Mingcute-Fill.svg.svg
  home41('Home-4-Line--Streamline-Mingcute.svg'), // Gốc: Home-4-Line--Streamline-Mingcute.svg.svg
  informationLine('Information Line Streamline Mingcute Line'), // Gốc: Information Line Streamline Mingcute Line.svg
  left('Left-Line--Streamline-Mingcute.svg'), // Gốc: Left-Line--Streamline-Mingcute.svg.svg
  location('Location-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Location-Fill--Streamline-Mingcute-Fill.svg.svg
  location1('Location-Line--Streamline-Mingcute.svg'), // Gốc: Location-Line--Streamline-Mingcute.svg.svg
  mail('Mail-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Mail-Fill--Streamline-Mingcute-Fill.svg.svg
  mail1('Mail-Line--Streamline-Mingcute.svg'), // Gốc: Mail-Line--Streamline-Mingcute.svg.svg
  notification('Notification-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: Notification-Fill--Streamline-Mingcute-Fill.svg.svg
  notification1('Notification-Line--Streamline-Mingcute.svg'), // Gốc: Notification-Line--Streamline-Mingcute.svg.svg
  rightLine('Right Line Streamline Mingcute Line'), // Gốc: Right Line Streamline Mingcute Line.svg
  rocketFill('Rocket Fill Streamline Mingcute Fill'), // Gốc: Rocket Fill Streamline Mingcute Fill.svg
  rocketLine('Rocket Line Streamline Mingcute Line'), // Gốc: Rocket Line Streamline Mingcute Line.svg
  sendFill('Send Fill Streamline Mingcute Fill'), // Gốc: Send Fill Streamline Mingcute Fill.svg
  shareForward('Share-Forward-Line--Streamline-Mingcute.svg'), // Gốc: Share-Forward-Line--Streamline-Mingcute.svg.svg
  starFill('Star Fill Streamline Mingcute Fill'), // Gốc: Star Fill Streamline Mingcute Fill.svg
  starLine('Star Line Streamline Mingcute Line'), // Gốc: Star Line Streamline Mingcute Line.svg
  time('Time-Line--Streamline-Mingcute.svg'), // Gốc: Time-Line--Streamline-Mingcute.svg.svg
  userAdd2Line('User Add 2 Line Streamline Mingcute Line'), // Gốc: User Add 2 Line Streamline Mingcute Line.svg
  userEditLine('User Edit Line Streamline Mingcute Line'), // Gốc: User Edit Line Streamline Mingcute Line.svg
  userFollow2Line('User Follow 2 Line Streamline Mingcute Line'), // Gốc: User Follow 2 Line Streamline Mingcute Line.svg
  userSettingLine('User Setting Line Streamline Mingcute Line'), // Gốc: User Setting Line Streamline Mingcute Line.svg
  user3('User-3-Fill--Streamline-Mingcute-Fill.svg'), // Gốc: User-3-Fill--Streamline-Mingcute-Fill.svg.svg
  user31('User-3-Line--Streamline-Mingcute.svg'), // Gốc: User-3-Line--Streamline-Mingcute.svg.svg
  userPin('User-Pin-Line--Streamline-Mingcute.svg'), // Gốc: User-Pin-Line--Streamline-Mingcute.svg.svg
  wallet4('Wallet-4-Line--Streamline-Mingcute.svg'), // Gốc: Wallet-4-Line--Streamline-Mingcute.svg.svg
  warning('Warning-Line--Streamline-Mingcute.svg'), // Gốc: Warning-Line--Streamline-Mingcute.svg.svg
  app('app-icon'), // Gốc: app-icon.svg
  dots('dots'), // Gốc: dots.svg
  google('google icon'), // Gốc: google icon.svg
  locationCheck('location_check'), // Gốc: location_check.svg
  locationCheckFilled('location_check_filled'), // Gốc: location_check_filled.svg
  search('search'),
  appIconGradient('app-icon-gradient'),
  fabGradient('fab_gradient'),
  gridLine('gridLine'),
  gridFilled('gridFilled');

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
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit,
      semanticsLabel: semanticsLabel ?? '${fileName.replaceAll('-', ' ')} icon', // Tạo label mặc định
    );
  }
}
