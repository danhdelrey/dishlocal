import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: colorScheme,
  textTheme: textTheme
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
