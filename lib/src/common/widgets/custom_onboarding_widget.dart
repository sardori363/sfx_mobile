import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class CustomOnboardingWidget extends StatelessWidget {
  const CustomOnboardingWidget({
    super.key,
    required this.text,
    required this.imagePath,
  });

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(imagePath, height: 320.h,),
        SizedBox(height: 45.h,),
        Text(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colorScheme.onPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        )
      ],
    );
  }
}
