import 'package:flutter/material.dart';

/// Central color palette for the portfolio.
///
/// A warm, ink-dark base with a coral / mint duotone accent —
/// deliberately steered away from the common blue-purple tech palette.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B0E11);
  static const Color backgroundAlt = Color(0xFF0F1317);
  static const Color surface = Color(0xFF14181D);
  static const Color surfaceElevated = Color(0xFF1B2027);
  static const Color border = Color(0xFF262C34);

  static const Color textPrimary = Color(0xFFF4F1EC);
  static const Color textSecondary = Color(0xFFAEB5BD);
  static const Color textMuted = Color(0xFF6E767F);

  static const Color coral = Color(0xFFFF7A50);
  static const Color coralSoft = Color(0xFFFFB08A);
  static const Color mint = Color(0xFF3ED9B5);
  static const Color gold = Color(0xFFE8C468);

  static const LinearGradient heroGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [coral, gold],
  );

  static const LinearGradient mintGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mint, coral],
  );
}
