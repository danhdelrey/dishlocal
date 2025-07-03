import 'dart:developer';

import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dishlocal/app/config/app_router.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logging/logging.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  _setupLogging();
  configureDependencies();
  await dotenv.load(fileName: ".env");
  timeago.setLocaleMessages('vi', ShortViMessages());

  await Supabase.initialize(
    url: AppEnvironment.supabaseUrl,
    anonKey: AppEnvironment.supabaseAnonKey,
  );

  // await Firebase.initializeApp(
  //   options: AppEnvironment.firebaseOption,
  // );


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Biến để tránh hiển thị hộp thoại nhiều lần
  bool _isUpdateChecked = false;
  final _log = Logger('_MyAppState');

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    // Chỉ kiểm tra cập nhật một lần khi widget được tạo
    if (!_isUpdateChecked) {
      _checkForUpdate();
      _isUpdateChecked = true;
    }
  }

  // Hàm kiểm tra và kích hoạt cập nhật
  Future<void> _checkForUpdate() async {
    _log.info("Kiểm tra cập nhật...");
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      // Kiểm tra xem có bản cập nhật không
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // Quyết định dùng loại cập nhật nào (Immediate hay Flexible)
        // Ở đây ví dụ ưu tiên Immediate nếu được phép
        if (updateInfo.immediateUpdateAllowed) {
          _log.info("Có bản cập nhật Tức thì (Immediate).");
          // Kích hoạt luồng cập nhật Tức thì
          AppUpdateResult result = await InAppUpdate.performImmediateUpdate();

          if (result == AppUpdateResult.success) {
            _log.info("Cập nhật Tức thì thành công!");
          } else {
            _log.info("Người dùng đã hủy cập nhật Tức thì.");
          }
        } else if (updateInfo.flexibleUpdateAllowed) {
          _log.info("Có bản cập nhật Linh hoạt (Flexible).");
          // Kích hoạt luồng cập nhật Linh hoạt
          AppUpdateResult result = await InAppUpdate.startFlexibleUpdate();

          if (result == AppUpdateResult.success) {
            _log.info("Bắt đầu tải cập nhật Linh hoạt.");
            // Sau khi tải xong, bạn phải tự kích hoạt cài đặt
            // Đây là bước quan trọng nhất của Flexible update
            await InAppUpdate.completeFlexibleUpdate();
            _log.info("Cập nhật Linh hoạt đã được cài đặt.");
          } else {
            _log.info("Người dùng đã hủy cập nhật Linh hoạt.");
          }
        }
      } else {
        _log.info("Không có bản cập nhật nào.");
      }
    } catch (e) {
      _log.info("Lỗi khi kiểm tra cập nhật: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
      child: Builder(builder: (context) {
        // Sử dụng Builder để lấy context có BlocProvider
        final router = AppRouter(context.read<AuthBloc>()).router;
        return MaterialApp.router(
          title: 'Flutter Demo',
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: AppEnvironment.isInDevelopment,
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
