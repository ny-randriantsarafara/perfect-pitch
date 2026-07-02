import 'package:flutter/widgets.dart';

/// Presentation layout the app renders in.
///
/// [desktop] uses the wide side-navigation layout; [mobile] uses the phone
/// frame with a floating bottom navigation.
enum LayoutMode { mobile, desktop }

/// Resolves the active [LayoutMode] from the current window.
///
/// Product rule: the desktop layout is only used in landscape on tablet-sized
/// screens and larger. Portrait always stays mobile, so phones and reduced
/// browser windows keep the mobile experience.
class LayoutResolver {
  const LayoutResolver._();

  static const double _tabletShortestSide = 600;

  static LayoutMode of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return fromSize(size);
  }

  static LayoutMode fromSize(Size size) {
    final isLandscape = size.width >= size.height;
    final isTabletOrLarger = size.shortestSide >= _tabletShortestSide;

    if (isLandscape && isTabletOrLarger) {
      return LayoutMode.desktop;
    }

    return LayoutMode.mobile;
  }
}
