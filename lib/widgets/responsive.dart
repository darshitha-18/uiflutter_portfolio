import 'package:flutter/widgets.dart';

/// Breakpoints used throughout the app. Kept intentionally simple:
/// mobile < 700 <= tablet < 1100 <= desktop.
class Responsive {
  Responsive._();

  static const double tablet = 700;
  static const double desktop = 1100;
  static const double maxContentWidth = 1120;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tablet;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= tablet && w < desktop;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;

  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < tablet) return 20;
    if (w < desktop) return 40;
    return 64;
  }
}
