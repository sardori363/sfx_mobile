import 'package:flutter/material.dart'
    show Brightness, Color, ColorScheme, Colors;

import 'app_colors.dart';

const ColorScheme lightColorScheme = ColorScheme.light(
  background: AppColors.backgroundLight,
  primary: AppColors.cardBackgroundLight,
  onPrimary: AppColors.textLight,
  onSecondary: AppColors.bottomSheetButtonsBackgroundLight,
  onSecondaryContainer: AppColors.bottomSheetDateTextLight,
  onSecondaryFixed: AppColors.bottomSheetSliderHandlerLight,
  onPrimaryContainer: AppColors.profileMaterialBtnLight,
  onPrimaryFixed: AppColors.green,
  tertiary: AppColors.keyContainerLight,
  onTertiary: AppColors.c939090,
  error: AppColors.error,
);

const ColorScheme darkColorScheme = ColorScheme.dark(
  background: AppColors.backgroundDark,
  primary: AppColors.cardBackgroundDark,
  onPrimary: AppColors.textDark,
  onPrimaryFixed: AppColors.green,
  onSecondary: AppColors.bottomSheetButtonsBackgroundDark,
  onSecondaryContainer: AppColors.bottomSheetDateTextDark,
  onSecondaryFixed: AppColors.bottomSheetSliderHandlerDark,
  tertiary: AppColors.keyContainerDark,
  error: AppColors.error,
  onPrimaryContainer: AppColors.profileMaterialBtnDark,
  onTertiary: AppColors.white,
);
