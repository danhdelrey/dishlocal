import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options_dev.dart' as dev_options;
import 'firebase_options_prod.dart' as prod_options;

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dishlocal/app/config/app_router.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/firebase_options.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logging/logging.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_vi;

bool isInDevelopmentEnvironment() {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );
  return environment == 'dev';
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  _setupLogging();
  configureDependencies();
  await dotenv.load(fileName: ".env"); //final String apiKey = dotenv.env['API_KEY_WEATHER'] ?? 'Không tìm thấy key';
  timeago.setLocaleMessages('vi', ShortViMessages());
  final packageInfo = await PackageInfo.fromPlatform();
  final appId = packageInfo.packageName;

  // Chọn đúng FirebaseOptions dựa trên môi trường
  final log = Logger('main()');
  FirebaseOptions options;
  if (!isInDevelopmentEnvironment()) {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL_PROD'] ?? 'Không tìm thấy key',
      anonKey: dotenv.env['SUPABASE_ANON_KEY_PROD'] ?? 'Không tìm thấy key',
    );
    options = prod_options.DefaultFirebaseOptions.currentPlatform;
    log.info('🚀 App đang chạy ở môi trường PRODUCTION');
    log.info('🚀 Package name hiện tại là: $appId');
  } else {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL_DEV'] ?? 'Không tìm thấy key',
      anonKey: dotenv.env['SUPABASE_ANON_KEY_DEV'] ?? 'Không tìm thấy key',
    );
    options = dev_options.DefaultFirebaseOptions.currentPlatform;
    log.info('👨‍🍳 App đang chạy ở môi trường DEVELOPMENT');
    log.info('👨‍🍳 Package name hiện tại là: $appId');
  }

  await Firebase.initializeApp(
    options: options,
  );

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
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
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
          debugShowCheckedModeBanner: isInDevelopmentEnvironment(),
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
