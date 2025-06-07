import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: colorScheme,
  textTheme: textTheme,
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        systemOverlayStyle: mySystemTheme,
      ),
);

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF899CCC),
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
