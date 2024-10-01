import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class CustomNextButtonWidget extends StatelessWidget {
  const CustomNextButtonWidget(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      height: 46.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      minWidth: MediaQuery.of(context).size.width,
      color: AppColors.yellow,
      onPressed: onPressed,
      child: Text(
        text,
        style: context.textTheme.titleMedium?.copyWith(
          color: AppColors.black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
