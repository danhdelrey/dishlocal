import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme(context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(context) => Theme.of(context).colorScheme;

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: colorScheme,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme(
    ThemeData.dark().textTheme
  ),
);

const colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFD735A),
  onPrimary: Colors.black,
  primaryContainer: Color(0xFFFFA07A),
  onPrimaryContainer: Colors.black,
  secondary: Color(0xFFFFB661),
  onSecondary: Colors.black,
  secondaryContainer: Color(0xFF5D3A2F),
  onSecondaryContainer: Colors.white,
  tertiary: Color(0xFFFF88A0),
  onTertiary: Colors.black,
  tertiaryContainer: Color(0xFF613844),
  onTertiaryContainer: Colors.white,
  error: Color(0xFFFF6B6B),
  onError: Colors.black,
  errorContainer: Color(0xFF5C1B1B),
  onErrorContainer: Colors.white,
  surface: Color(0xFF211A18),
  onSurface: Colors.white,
  onSurfaceVariant: Color(0xFFCCCCCC),
  outline: Color(0xFF757575),
  outlineVariant: Color(0xFF505050),
  shadow: Color(0x99000000),
  scrim: Color(0x66000000),
  inverseSurface: Color(0xFFEDEDED),
  onInverseSurface: Color(0xFF212121),
  inversePrimary: Color(0xFFFFA07A),
  surfaceTint: Color(0xFFFD735A),
);

const String sfProDisplayFontFamily = 'SFProDisplay';
final TextTheme defaultTextTheme = ThemeData.dark().textTheme;
final textTheme = defaultTextTheme.apply(
  fontFamily: sfProDisplayFontFamily,
);
