import 'package:flutter/material.dart';

import '../../../common/styles/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(40, 40),
        shape: const CircleBorder(),
        backgroundColor: AppColors.white,
        overlayColor: AppColors.black,
      ),
      child: Icon(
        icon,
        color: AppColors.black,
      ),
    );
  }
}
