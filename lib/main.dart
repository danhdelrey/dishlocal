import 'dart:developer';

import 'package:dishlocal/core/app_environment/app_environment.dart';
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
