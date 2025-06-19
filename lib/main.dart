import 'dart:developer';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dishlocal/app/config/app_router.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/firebase_options.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_vi;



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env"); //final String apiKey = dotenv.env['API_KEY_WEATHER'] ?? 'Không tìm thấy key';
  timeago.setLocaleMessages('vi', ShortViMessages());
  
  configureDependencies();
  _setupLogging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Builder(builder: (context) {
        // Sử dụng Builder để lấy context có BlocProvider
        final router = AppRouter(context.read<AuthBloc>()).router;
        return MaterialApp.router(
          title: 'Flutter Demo',
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      }),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // Tự thêm record.time vào chuỗi message chính
    final message = '[${record.level.name}] '
        '${record.time.toIso8601String().substring(11, 23)} ----- ' // Định dạng giờ:phút:giây.mili
        '${record.message} -----';

    log(
      message, // Message đã được định dạng đầy đủ
      time: record.time, // Vẫn gửi time để DevTools hiển thị đúng
      level: record.level.value,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
