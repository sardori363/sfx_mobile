import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/generated/assets.dart';
import 'package:sfx/src/common/routing/app_route_name.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/common/widgets/custom_next_button_widget.dart';
import 'package:sfx/src/feature/init/bloc/splash_bloc.dart';
import 'package:sfx/src/feature/init/widgets/language_button_widget.dart';
import 'package:sfx/src/feature/init/widgets/theme_button_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return Scaffold(
      backgroundColor: contextColor.background,
      appBar: AppBar(
        actions: [
          SizedBox(width: 24.w),
          const ThemeButtonWidget(),
          const Spacer(),
          const LanguageButtonWidget(),
          SizedBox(width: 24.w),
        ],
      ),
      body: BlocProvider(
        create: (context) => SplashPageBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Center(child: Image.asset(Assets.imagesSfxSplash)),
              const SizedBox(height: 50,),
              Text(
                "Descriptive text",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  color: contextColor.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp),
              ),
              const Spacer(),
              CustomNextButtonWidget(text: "Boshlash", onPressed: (){context.push(AppRouteName.otpPage);}),
              SizedBox(height: 30.h,)
            ],
          ),
        ),
      ),
    );
  }
}
