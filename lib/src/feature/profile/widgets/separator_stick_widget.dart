import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class SeparatorStickWidget extends StatelessWidget {
  const SeparatorStickWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 1.h,
        color: context.colorScheme.onPrimaryContainer,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            width: double.infinity,
            color: context.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
