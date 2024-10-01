import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/src/common/routing/app_route_name.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

import '../../../generated/assets.dart';
import '../../common/widgets/back_button_widget.dart';
import '../../common/widgets/custom_next_button_widget.dart';
import 'bloc/otp_bloc.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 40.h,
          ),
          child: Column(
            children: [
              const BackButtonWidget(),
              SizedBox(
                height: 160.h,
              ),
              Image.asset(Assets.imagesTelegram),
              SizedBox(
                height: 40.h,
              ),
              Text(
                context.localized.special_code,
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text.rich(
                TextSpan(
                  text: context.localized.tg,
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
                      text: context.localized.get_from_bot,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              BlocConsumer<OtpBloc, OtpState>(
                listener: (context, state) {
                  if (state is OtpLinkOpenedFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not open Telegram link.'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomNextButtonWidget(
                    text: context.localized.get_code,
                    onPressed: () {
                      context.pushReplacement(
                        AppRouteName.otpInputPage,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
