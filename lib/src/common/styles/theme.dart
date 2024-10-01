import 'dart:ui';

import 'package:flutter/material.dart'
    show AppBarTheme, Brightness, ThemeData, ThemeMode, immutable;
import 'package:sfx/src/common/styles/color_scheme.dart';
import 'package:sfx/src/common/styles/text_style.dart';

import 'app_colors.dart';

ThemeData lightMode = ThemeData(
  textTheme: const AppTextStyle(),
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
  ),
);

ThemeData darkMode = ThemeData(
  textTheme: const AppTextStyle(),
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
  ),
);

@immutable
final class AppTheme {
  /// {@macro app_theme}
  AppTheme({required this.mode})
      : darkTheme = darkMode,
        lightTheme = lightMode;

  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  static ThemeData light() => lightMode;

  static ThemeData dark() => darkMode;

  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          mode == other.mode;

  @override
  int get hashCode => mode.hashCode;
}
