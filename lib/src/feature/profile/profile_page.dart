import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/feature/profile/bloc/profile_bloc.dart';
import 'package:sfx/src/feature/profile/bloc/profile_event.dart';
import 'package:sfx/src/feature/profile/bloc/profile_state.dart';
import 'package:sfx/src/feature/profile/widgets/arrow_button_widget.dart';
import 'package:sfx/src/feature/profile/widgets/no_user_found_widget.dart';
import 'package:sfx/src/feature/profile/widgets/separator_stick_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/language_switch/language_widget.dart';
import '../../common/widgets/theme_switch/theme_picker_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = Theme
        .of(context)
        .colorScheme;
    return BlocProvider(
      create: (context) =>
      ProfileBloc()
        ..add(GetProfileDataEvent()),

      /// todo
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.pageState == ProfilePageState.loading
              ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ))
              : Scaffold(
            backgroundColor: contextColor.background,
            body: Padding(
              padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localized.profile_title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 20.sp,
                      color: contextColor.onPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  state.pageState == ProfilePageState.userNotRegistered
                      ? const NoUserFoundWidget()
                      : UserFoundWidget(
                      fullName: state.profileData['full_name'] ?? 'no user name',
                      phoneNumber: state.profileData['phone_number'] ?? 'no user phone'),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    context.localized.settings,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 20.sp,
                      color: contextColor.onPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ArrowButtonWidget(
                    text: context.localized.profile_language,
                    isUpCurved: true,
                    isDownCurved: false,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                        const LanguageSelectionBottomSheetWidget(),
                      );
                    },
                  ),
                  const SeparatorStickWidget(),
                  ArrowButtonWidget(
                    text: context.localized.profile_theme,
                    isUpCurved: false,
                    isDownCurved: true,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const CustomThemeWidget(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ArrowButtonWidget(
                    text: context.localized.profile_contact,
                    isUpCurved: true,
                    isDownCurved: true,
                    onPressed: () async {
                      final Uri telegramUrl =
                      Uri.parse('https://t.me/sfxs_bot');
                      try {
                        await launchUrl(telegramUrl);
                      } catch (e) {
                        const SnackBar(
                            content:
                            Text('Failed to open Telegram link.'));
                        debugPrint('Could not launch URL: $e');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
