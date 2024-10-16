import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/generated/assets.dart';
import 'package:sfx/src/common/routing/app_route_name.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return Scaffold(
      backgroundColor: contextColor.background,
      body: Container(
        height: 500.h,
        margin: EdgeInsets.only(top: 150.h, left: 40.w, right: 40.w, bottom: 250.h),
        padding: EdgeInsets.only(top: 0, right: 24.w, left: 24.w, bottom: 24.h),
        decoration: BoxDecoration(
          color: contextColor.onPrimaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: SvgPicture.asset(Assets.iconsSuccessLarge, fit: BoxFit.fill,),
            ),
            Text(
              "Uyga vazifa muvaffaqiyatli yuklandi.",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const Spacer(),
            MaterialButton(
              elevation: 0,
              height: 50.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minWidth: 230.w,
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

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: 500.h,
        margin: EdgeInsets.only(top: 150.h, left: 40.w, right: 40.w),
        padding: EdgeInsets.only(top: 0, right: 24.w, left: 24.w, bottom: 24.h),
        decoration: BoxDecoration(
          color: contextColor.onPrimaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: Image.asset(Assets.imagesError, fit: BoxFit.fill,),
            ),
            Text(
              "Xatolik yuz berdi! Xatolik sababi sizning akkauntingiz aktiv emasligi bo'lishi mumkin.",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const Spacer(),
            MaterialButton(
              elevation: 0,
              height: 50.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minWidth: 230.w,
              color: AppColors.red,
              onPressed: () async{
                final Uri telegramUrl = Uri.parse('https://t.me/ssirojiddinov1');
                await launchUrl(telegramUrl);
              },
              child: Text(
                "Admin bilan bog'lanish",
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
