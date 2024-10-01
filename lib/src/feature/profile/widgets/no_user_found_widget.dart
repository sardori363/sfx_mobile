import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/src/common/local/app_storage.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/feature/profile/bloc/profile_bloc.dart';
import 'package:sfx/src/feature/profile/bloc/profile_event.dart';

import '../../../../generated/assets.dart';
import '../../../common/routing/app_route_name.dart';

class NoUserFoundWidget extends StatelessWidget {
  const NoUserFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.imagesProfilePng,
          width: 48.w,
          height: 48.h,
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localized.new_user,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              context.localized.register,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 50.w,
          child: MaterialButton(
            onPressed: () async{
              await Future.delayed(const Duration(milliseconds: 500));
              context.push(AppRouteName.otpPage);
              debugPrint("login button is being pressed");
            },
            padding: EdgeInsets.zero,
            color: context.colorScheme.onPrimaryContainer,
            height: 50.h,
            splashColor: AppColors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: SvgPicture.asset(Assets.iconsLogin),
          ),
        )
      ],
    );
  }
}

class UserFoundWidget extends StatefulWidget {
  const UserFoundWidget(
      {super.key, required this.fullName, required this.phoneNumber});

  final String fullName;
  final String phoneNumber;

  @override
  State<UserFoundWidget> createState() => _UserFoundWidgetState();
}

class _UserFoundWidgetState extends State<UserFoundWidget> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.imagesProfilePng,
          width: 48.w,
          height: 48.h,
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fullName,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.phoneNumber,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 50.w,
          child: MaterialButton(
            onPressed: () async{
              await AppStorage.$delete(key: StorageKey.accessToken);
              await Future.delayed(const Duration(milliseconds: 500));
              context.go(AppRouteName.splashPage);
              debugPrint("log out button is being pressed");
            },
            padding: EdgeInsets.zero,
            color: context.colorScheme.onPrimaryContainer,
            height: 50.h,
            splashColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: SvgPicture.asset(Assets.iconsLogout),
          ),
        )
      ],
    );
  }
}

