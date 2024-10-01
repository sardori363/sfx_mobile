import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sfx/src/common/routing/app_route_name.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

import '../../common/widgets/back_button_widget.dart';
import '../main/bloc/bottom_nav.dart';
import 'bloc/otp_bloc.dart';

class OtpInputPage extends StatefulWidget {
  const OtpInputPage({super.key});

  @override
  State<OtpInputPage> createState() => _OtpInputPageState();
}

class _OtpInputPageState extends State<OtpInputPage> {
  TextEditingController otpKeyController = TextEditingController();

  @override
  void dispose() {
    otpKeyController.clear();
    otpKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultTheme = PinTheme(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 10.h,
      ),
      margin: EdgeInsets.only(
        bottom: 30.h,
      ),
      textStyle: context.textTheme.headlineMedium!.copyWith(
        color: context.colorScheme.onPrimary,
        fontSize: 26.sp,
      ),
      width: 50.w,
      height: 66.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorScheme.tertiary,
        ),
      ),
    );

    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(0);
            context.push(AppRouteName.homePage);
          } else if (state is OtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                dismissDirection: DismissDirection.up,
                duration: const Duration(seconds: 3),
                backgroundColor: AppColors.error,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 120,
                  left: 20,
                  right: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  context.localized.error_on_code,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            );
          } else if (state is OtpLinkOpenedFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to open Telegram link.')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
              vertical: 40.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BackButtonWidget(),
                SizedBox(height: 60.h),
                Text(
                  context.localized.enter_code,
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontSize: 32.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text.rich(
                  TextSpan(
                    text: context.localized.tg2,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onPrimary,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "@sfxtrading_bot",
                        style: context.theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.yellow,
                          fontSize: 16.sp,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          context.read<OtpBloc>().add(OpenTelegramLinkEvent());
                        },
                      ),
                      TextSpan(
                        text: context.localized.enter_from_tg,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.h),
                Pinput(
                  controller: otpKeyController,
                  length: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  separatorBuilder: (index) => SizedBox(width: 8.w),
                  validator: (value) {
                    if (state is OtpError) {
                      return context.localized.error_on_code;
                    }
                    return null;
                  },
                  toolbarEnabled: false,
                  enableSuggestions: false,
                  errorTextStyle: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.error,
                    fontSize: 12.sp,
                  ),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) async {
                    debugPrint("onCompleted");
                    await Future.delayed(const Duration(milliseconds: 500), () {
                      context.read<OtpBloc>().add(OtpSubmitted(pin));
                    });
                    debugPrint(state.toString());
                  },
                  defaultPinTheme: defaultTheme,
                  focusedPinTheme: defaultTheme.copyWith(
                    decoration: defaultTheme.decoration!.copyWith(
                      border: Border.all(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  submittedPinTheme: defaultTheme.copyWith(
                    decoration: defaultTheme.decoration!.copyWith(
                      border: Border.all(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  errorPinTheme: defaultTheme.copyWith(
                    decoration: defaultTheme.decoration!.copyWith(
                      border: Border.all(
                        color: context.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
