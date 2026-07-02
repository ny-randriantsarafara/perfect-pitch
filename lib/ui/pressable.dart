import 'package:flutter/widgets.dart';

/// Wraps a tappable element with the subtle press-scale feedback used
/// throughout the designer reference (Tailwind's `active:scale-*`).
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    required this.onTap,
    this.pressedScale = 0.95,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final bool enabled;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _pressed = false;

  bool get _isInteractive {
    return widget.enabled && widget.onTap != null;
  }

  void _setPressed(bool value) {
    if (!_isInteractive) {
      return;
    }

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _isInteractive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isInteractive ? widget.onTap : null,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedScale(
          scale: _pressed ? widget.pressedScale : 1,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
