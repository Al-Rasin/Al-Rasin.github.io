import 'package:flutter/material.dart';

/// Warm paper background, near-black ink and a single rust accent that is
/// only ever used for links.
class AppColors {
  static const bg = Color(0xFFF6F5F1);
  static const text = Color(0xFF21201C);
  static const heading = Color(0xFF111110);
  static const muted = Color(0xFF6F6D66);
  static const line = Color(0xFFE3E1DA);
  static const accent = Color(0xFF9A3B26);
}

class AppText {
  static const serif = 'Newsreader';
  static const mono = 'PlexMono';

  static const body = TextStyle(
    fontFamily: serif,
    fontSize: 18,
    height: 1.6,
    color: AppColors.text,
  );

  static const name = TextStyle(
    fontFamily: serif,
    fontSize: 30,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.heading,
  );

  static const sectionTitle = TextStyle(
    fontFamily: serif,
    fontSize: 15,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );

  static const itemTitle = TextStyle(
    fontFamily: serif,
    fontSize: 20,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );

  static final muted = body.copyWith(color: AppColors.muted);

  static const small = TextStyle(
    fontFamily: serif,
    fontSize: 16,
    height: 1.5,
    color: AppColors.muted,
  );

  static const code = TextStyle(
    fontFamily: mono,
    fontSize: 13,
    height: 1.6,
    color: AppColors.muted,
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppText.serif,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.accent,
      surface: AppColors.bg,
      onSurface: AppColors.text,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.accent.withValues(alpha: 0.18),
      cursorColor: AppColors.accent,
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  );
}
