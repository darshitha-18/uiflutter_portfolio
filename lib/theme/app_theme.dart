import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App-wide [ThemeData]. Uses the platform default font family (Roboto on
/// web) but leans on deliberate weight / letter-spacing / size choices to
/// give headings a tighter, more editorial feel than default Material type.
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.coral,
        secondary: AppColors.mint,
        surface: AppColors.surface,
      ),
      textTheme: _textTheme(base.textTheme),
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dividerColor: AppColors.border,
      visualDensity: VisualDensity.standard,
    );
  }

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.05,
      ),
      displayMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        height: 1.1,
      ),
      headlineMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineSmall: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      titleLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: const TextStyle(
        color: AppColors.textSecondary,
        height: 1.6,
        fontSize: 16,
      ),
      bodyMedium: const TextStyle(
        color: AppColors.textSecondary,
        height: 1.55,
        fontSize: 14.5,
      ),
      labelLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
      labelSmall: const TextStyle(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
    );
  }
}
