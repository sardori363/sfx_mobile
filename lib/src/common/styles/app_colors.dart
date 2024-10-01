import "dart:ui";

import "package:flutter/material.dart";
import "package:meta/meta.dart";

@immutable
final class AppColors {
  const AppColors._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color green = Color(0xFF65B449);
  static const Color yellow = Color(0xFFF7EB00);
  static const Color red = Color(0xFFFF0000);
  static const Color navbarIcon = Color(0xFF626262);
  static const Color stick = Color(0xFFD5D5D5);
  static const Color error = Color(0xFFE85136);
  static const Color transparent = Colors.transparent;

  // light
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xffF6F6F6);
  static const Color textLight = Color(0xFF000000);
  static const Color navbarBackgroundLight = Color(0xFFFFFFFF);
  static const Color bottomSheetButtonsBackgroundLight = Color(0xFFEDEDED);
  static const Color bottomSheetDateTextLight = Color(0xFF626262);
  static const Color bottomSheetSliderHandlerLight = Color(0xFFEDEDED);
  static const Color profileMaterialBtnLight = Color(0xFFFFFFFF);
  static const Color keyContainerLight = Color(0xFFCDCFCE);
  static const Color c939090 = Color(0xFF939090);

  // dark
  static const Color cardBackgroundDark = Color(0xFF1E1E1E);
  static const Color backgroundDark = Color(0xff131313);
  static const Color textDark = Color(0xFFFFFFFF);
  static const Color navbarBackgroundDark = Color(0xFF131313);
  static const Color bottomSheetButtonsBackgroundDark = Color(0xFF3D3D3D);
  static const Color bottomSheetDateTextDark = Color(0xFFD5D5D5);
  static const Color bottomSheetSliderHandlerDark = Color(0xFF3D3D3D);
  static const Color profileMaterialBtnDark = Color(0xFF2A2A2A);
  static const Color keyContainerDark = Color(0xFF2A2A2A);
}
