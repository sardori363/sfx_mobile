import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key, required this.given, required this.left, required this.completed});

  final int given;
  final int left;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Berilgan uy ishlari",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      "$given",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                          fontSize: 28.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                // height: ,
                decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Qolgan uy ishlari",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      "$left",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                          fontSize: 28.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h,),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Bajarilgan uy ishlari",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Text(
                      "$completed",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                          fontSize: 28.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
