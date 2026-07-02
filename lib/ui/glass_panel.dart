import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';

/// Frosted surface used across the app: a low-alpha white fill with a hairline
/// border and an optional backdrop blur, matching the glassmorphism of the
/// designer reference.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 24,
    this.fillAlpha = 0.03,
    this.borderAlpha = 0.08,
    this.blur = 12,
    this.clip = false,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double fillAlpha;
  final double borderAlpha;
  final double blur;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: AppPalette.whiteAlpha(fillAlpha),
        borderRadius: radius,
        border: Border.all(color: AppPalette.whiteAlpha(borderAlpha)),
      ),
      child: Padding(padding: padding, child: child),
    );

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: clip ? ClipRRect(borderRadius: radius, child: content) : content,
      ),
    );
  }
}
