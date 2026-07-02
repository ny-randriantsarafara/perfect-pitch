import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';

/// Dark, high-contrast theme aligned with the designer reference: a sans-serif
/// type scale on the near-black canvas with violet as the seed color.
class PerfectPitchTheme {
  const PerfectPitchTheme._();

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppPalette.violet500,
      brightness: Brightness.dark,
      primary: AppPalette.violet500,
      secondary: AppPalette.fuchsia500,
      surface: AppPalette.frame,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppPalette.canvas,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme,
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
      color: AppPalette.white,
    ),
    displayMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      letterSpacing: -1,
      color: AppPalette.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: AppPalette.white,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppPalette.white,
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 1.4, color: AppPalette.white),
    bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: AppPalette.white),
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.5,
      color: AppPalette.white,
    ),
  );
}
