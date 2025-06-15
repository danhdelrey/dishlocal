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
  seedColor: const Color(0xFFFF8C69),
  brightness: Brightness.dark,
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
