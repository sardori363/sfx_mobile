import 'package:flutter/cupertino.dart';

@immutable
class SplashScreenModel {
  final String text;
  final String imagePath;

  const SplashScreenModel({
    required this.imagePath,
    required this.text,
  });
}
