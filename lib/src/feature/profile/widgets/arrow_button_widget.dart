import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class ArrowButtonWidget extends StatelessWidget {
  const ArrowButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isUpCurved,
    required this.isDownCurved,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isUpCurved;
  final bool isDownCurved;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: isUpCurved ? Radius.circular(12.r) : Radius.zero,
          topRight: isUpCurved ? Radius.circular(12.r) : Radius.zero,
          bottomLeft: isDownCurved ? Radius.circular(12.r) : Radius.zero,
          bottomRight: isDownCurved ? Radius.circular(12.r) : Radius.zero,
        ),
      ),
      color: context.colorScheme.onPrimaryContainer,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.onPrimary,
              fontSize: 16.sp,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: 24,
            color: context.colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
