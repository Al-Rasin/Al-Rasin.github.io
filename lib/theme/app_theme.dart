import 'package:flutter/material.dart';

/// Warm near-black page, off-white type and one signal orange.
class AppColors {
  static const bg = Color(0xFF0F0F0D);
  static const raised = Color(0xFF181816);
  static const text = Color(0xFFE9E6DF);
  static const heading = Color(0xFFF7F5F0);
  static const muted = Color(0xFF8E8B83);
  static const line = Color(0xFF2A2925);
  static const accent = Color(0xFFFF6B35);
}

class AppText {
  static const display = 'Bricolage';
  static const mono = 'PlexMono';

  /// Bricolage is a variable font, so weight and width go through axes.
  static List<FontVariation> axes(double weight, {double width = 100}) => [
    FontVariation('wght', weight),
    FontVariation('wdth', width),
    const FontVariation('opsz', 48),
  ];

  /// Huge condensed headline. Size is set by the caller.
  static TextStyle headline(double size) => TextStyle(
    fontFamily: display,
    fontSize: size,
    height: 0.9,
    letterSpacing: -size * 0.03,
    fontWeight: FontWeight.w800,
    fontVariations: axes(800, width: 75),
    color: AppColors.heading,
  );

  static final body = TextStyle(
    fontFamily: display,
    fontSize: 18,
    height: 1.55,
    fontVariations: axes(400),
    color: AppColors.text,
  );

  static final lead = TextStyle(
    fontFamily: display,
    fontSize: 26,
    height: 1.3,
    letterSpacing: -0.3,
    fontWeight: FontWeight.w500,
    fontVariations: axes(500),
    color: AppColors.heading,
  );

  static final itemTitle = TextStyle(
    fontFamily: display,
    fontSize: 40,
    height: 1.0,
    letterSpacing: -1,
    fontWeight: FontWeight.w700,
    fontVariations: axes(700, width: 80),
    color: AppColors.heading,
  );

  static final muted = body.copyWith(color: AppColors.muted);

  static final small = TextStyle(
    fontFamily: display,
    fontSize: 15,
    height: 1.5,
    fontVariations: axes(400),
    color: AppColors.muted,
  );

  static const code = TextStyle(
    fontFamily: mono,
    fontSize: 13,
    height: 1.6,
    letterSpacing: 0.2,
    color: AppColors.muted,
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppText.display,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.bg,
      onSurface: AppColors.text,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.accent.withValues(alpha: 0.35),
      cursorColor: AppColors.accent,
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  );
}
