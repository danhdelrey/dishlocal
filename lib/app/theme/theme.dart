import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextTheme appTextTheme(context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(context) => Theme.of(context).colorScheme;

final darkTheme = ThemeData.dark().copyWith(
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          systemOverlayStyle: mySystemTheme,
        ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }));

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFD735A),
  brightness: Brightness.dark,
  primary: const Color(0xFFFD735A), // Cam hồng dịu
  onPrimary: Colors.black, // Đảm bảo đọc được chữ

  primaryContainer: const Color(0xFFFFA07A), // Màu sáng hơn cho container
  onPrimaryContainer: Colors.black,

  secondary: const Color(0xFFFFB661), // Tông hồng cam nhạt
  onSecondary: Colors.black,
  secondaryContainer: const Color(0xFF5D3A2F), // Tông trầm để nổi bật nội dung
  onSecondaryContainer: Colors.white,

  tertiary: const Color(0xFFFF88A0), // Hồng đào
  onTertiary: Colors.black,
  tertiaryContainer: const Color(0xFF613844),
  onTertiaryContainer: Colors.white,

  error: const Color(0xFFFF6B6B),
  onError: Colors.black,
  errorContainer: const Color(0xFF5C1B1B),
  onErrorContainer: Colors.white,

  

  surface: const Color(0xFF1E1E1E),
  onSurface: Colors.white,

  onSurfaceVariant: const Color(0xFFCCCCCC),

  outline: const Color(0xFF757575),
  outlineVariant: const Color(0xFF505050),

  shadow: Colors.black,
  scrim: Colors.black.withOpacity(0.5),

  surfaceTint: const Color(0xFFFD735A), // Giữ nguyên theo màu chủ đạo

  inverseSurface: const Color(0xFFEDEDED),
  onInverseSurface: const Color(0xFF212121),
  inversePrimary: const Color(0xFFFFA07A),

  // Các màu bổ sung của Material 3
  primaryFixed: const Color(0xFFFFA07A),
  primaryFixedDim: const Color(0xFFFD735A),
  onPrimaryFixed: Colors.black,
  onPrimaryFixedVariant: Colors.white,

  secondaryFixed: const Color(0xFFFFB661),
  secondaryFixedDim: const Color(0xFFD97E49),
  onSecondaryFixed: Colors.black,
  onSecondaryFixedVariant: Colors.white,

  tertiaryFixed: const Color(0xFFFF88A0),
  tertiaryFixedDim: const Color(0xFFDB6E83),
  onTertiaryFixed: Colors.black,
  onTertiaryFixedVariant: Colors.white,

  surfaceDim: const Color(0xFF181818),
  surfaceBright: const Color(0xFF2C2C2C),

  surfaceContainerLowest: const Color(0xFF0F0F0F),
  surfaceContainerLow: const Color(0xFF1C1C1C),
  surfaceContainer: const Color(0xFF232323),
  surfaceContainerHigh: const Color(0xFF2A2A2A),
  surfaceContainerHighest: const Color(0xFF313131),
);

const String sfProDisplayFontFamily = 'SFProDisplay';
final TextTheme defaultTextTheme = ThemeData.dark().textTheme;
final textTheme = defaultTextTheme.apply(
  fontFamily: sfProDisplayFontFamily,
);

final mySystemTheme = SystemUiOverlayStyle(
  systemNavigationBarColor: ThemeData.dark().scaffoldBackgroundColor,
  systemNavigationBarIconBrightness: Brightness.dark,
);
