import 'package:flutter/widgets.dart';

/// Soft radial light used to give the dark canvas depth, mirroring the blurred
/// violet / fuchsia glows in the designer reference.
///
/// A radial gradient is used instead of a blur filter because it produces the
/// same soft halo at a fraction of the rendering cost.
class AmbientGlow extends StatelessWidget {
  const AmbientGlow({required this.color, required this.diameter, super.key});

  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
