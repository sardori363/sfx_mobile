import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import '../../../common/local/app_storage.dart';
import '../../../common/styles/theme.dart';

class ThemeCubit extends Cubit<ThemeData> with WidgetsBindingObserver {
  ThemeCubit()
      : super(
          ui.window.platformBrightness != ui.Brightness.dark
              ? AppTheme.light()
              : AppTheme.dark(),
        ) {
    _loadTheme();
    // WidgetsBinding.instance.addObserver(this);

    ///we can uncomment this part if we want device's mode to affect the app's theme
  }

  bool isLight = ui.window.platformBrightness != ui.Brightness.dark;
  bool currentLightMode = ui.window.platformBrightness != ui.Brightness.dark;

  void _loadTheme() async {
    try {
      final String? theme = await AppStorage.$read(key: StorageKey.theme);
      debugPrint("Loaded theme: $theme"); // Log the loaded theme

      if (theme != null &&
          theme.toLowerCase() != (isLight ? 'true' : 'false')) {
        isLight = theme.toLowerCase() == 'true';
        emit(isLight ? AppTheme.light() : AppTheme.dark());
        currentLightMode = isLight;
        emit(currentLightMode ? AppTheme.light() : AppTheme.dark());
      }
    } catch (error) {
      l.w(error);
    }
  }

  void setTheme(bool isLightMode) async {
    isLight = isLightMode;
    emit(isLight ? AppTheme.light() : AppTheme.dark());

    try {
      await AppStorage.$write(key: StorageKey.theme, value: isLight.toString());
    } catch (error) {
      l.w(error);
    }
  }

  void setAppTheme(bool isLightMode) async {
    currentLightMode = isLightMode;
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isCurrentlyLight = brightness != ui.Brightness.dark;

    if (isCurrentlyLight != isLight) {
      isLight = isCurrentlyLight;
      emit(isLight ? AppTheme.light() : AppTheme.dark());
    }
  }

  // @override
  // Future<void> close() {
  //   WidgetsBinding.instance.removeObserver(this); // Remove observer on close
  //   return super.close();
  // }

  /// have to uncomment it if u want to use observer widget
}
