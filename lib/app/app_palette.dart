import 'package:flutter/widgets.dart';

/// Central color tokens mirroring the designer reference (Tailwind violet /
/// fuchsia palette on a near-black canvas). Kept as a single source of truth so
/// every screen stays visually consistent.
class AppPalette {
  const AppPalette._();

  static const Color canvas = Color(0xFF050505);
  static const Color frame = Color(0xFF0A0710);
  static const Color frameElevated = Color(0xFF120D1D);

  static const Color cardTop = Color(0xFF2D1B4E);
  static const Color cardBottom = Color(0xFF1A0B2E);

  static const Color navSurface = Color(0xFF1A1528);

  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color violet400 = Color(0xFFA78BFA);
  static const Color violet300 = Color(0xFFC4B5FD);
  static const Color violet200 = Color(0xFFDDD6FE);
  static const Color violet900 = Color(0xFF4C1D95);

  static const Color fuchsia600 = Color(0xFFC026D3);
  static const Color fuchsia500 = Color(0xFFD946EF);
  static const Color fuchsia400 = Color(0xFFE879F9);

  static const Color green500 = Color(0xFF22C55E);
  static const Color green400 = Color(0xFF4ADE80);

  static const Color red500 = Color(0xFFEF4444);
  static const Color red400 = Color(0xFFF87171);

  static const Color orange400 = Color(0xFFFB923C);

  static const Color white = Color(0xFFFFFFFF);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc600 = Color(0xFF52525B);

  static Color whiteAlpha(double alpha) {
    return white.withValues(alpha: alpha);
  }
}
