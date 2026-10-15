import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF08090B);
  static const surface = Color(0xFF0F1013);
  static const border = Color(0xFF1E2025);
  static const borderHover = Color(0xFF2E3138);
  static const text = Color(0xFFEDEDEF);
  static const muted = Color(0xFF8A8F98);
  static const subtle = Color(0xFF5B606A);

  /// The single accent color, used sparingly for highlights and glow.
  static const accent = Color(0xFF7C83FF);

  static const headlineGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFF9EA3AD)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static const font = 'Geist';

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    fontFamily: font,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.bg,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.accent.withValues(alpha: .35),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w600,
        height: 1.05,
        letterSpacing: -3,
        color: AppColors.text,
      ),
      headlineLarge: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -1.6,
        color: AppColors.text,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -.3,
        color: AppColors.text,
      ),
      bodyLarge: TextStyle(fontSize: 18, height: 1.6, color: AppColors.muted),
      bodyMedium: TextStyle(
        fontSize: 14.5,
        height: 1.6,
        color: AppColors.muted,
      ),
    ),
  );
}
