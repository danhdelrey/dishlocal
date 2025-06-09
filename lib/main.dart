import 'dart:developer';

import 'package:dishlocal/app/config/router.dart';
import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies();
  _setupLogging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

void _setupLogging() {
  // Không cần kiểm tra kDebugMode nữa vì log() đã tự xử lý
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // 2. Thay thế print() bằng log()
    log(
      // Message chính
      '${record.loggerName}: ${record.message}',

      // Các tham số tùy chọn của hàm log()
      time: record.time,
      level: record.level.value, // Level được biểu thị bằng số nguyên
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
