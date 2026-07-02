import 'package:flutter/material.dart';
import 'package:perfect_pitch/app/app_palette.dart';

/// Text painted with the signature white-to-translucent gradient used for the
/// large headings in the designer reference.
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.style,
    this.gradient = _defaultGradient,
    super.key,
  });

  static const LinearGradient _defaultGradient = LinearGradient(
    colors: [AppPalette.white, Color(0x99FFFFFF)],
  );

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(text, style: style.copyWith(color: AppPalette.white)),
    );
  }
}
