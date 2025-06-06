import 'package:dishlocal/app/config/router.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Đặt hàm của bạn ở đây (hoặc import từ file khác)
void overlaySystemNavigationBar() {
  // Đảm bảo bạn đã import 'package:flutter/services.dart';
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarIconBrightness:
          Brightness.dark, // Các icon (home, back) sẽ là màu tối
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.dark, // Các icon trên status bar (pin, wifi) sẽ là màu tối
    ),
  );

}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  overlaySystemNavigationBar();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
