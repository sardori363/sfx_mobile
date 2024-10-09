import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/generated/assets.dart';
import 'package:sfx/src/common/routing/app_route_name.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return Scaffold(
      backgroundColor: contextColor.background,
      body: Container(
        height: 510,
        margin: EdgeInsets.only(top: 150.h, left: 40.w, right: 40.w, bottom: 150.h),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: contextColor.onPrimaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(Assets.iconsSuccessLarge),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Uyga vazifa muvaffaqiyatli yuklandi.",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              elevation: 0,
              height: 46.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minWidth: 230,
              color: AppColors.green,
              onPressed: () {
                context.go(AppRouteName.homePage);
              },
              child: Text(
                "Asosiyga qaytish",
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
