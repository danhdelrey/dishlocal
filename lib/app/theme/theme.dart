import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme(context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(context) => Theme.of(context).colorScheme;

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFD735A),
    brightness: Brightness.dark,
    primary: const Color(0xFFFD735A),
    outlineVariant: CupertinoColors.systemFill,
  ),
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  //   },
  // ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
);

// const String sfProDisplayFontFamily = 'SFProDisplay';
// final TextTheme defaultTextTheme = ThemeData.dark().textTheme;
// final textTheme = defaultTextTheme.apply(
//   fontFamily: sfProDisplayFontFamily,
// );
