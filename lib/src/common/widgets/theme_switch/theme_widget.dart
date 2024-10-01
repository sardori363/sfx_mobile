import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/common/widgets/theme_switch/custom_theme_picker.dart';
import '../../../feature/profile/bloc/profile_bloc.dart';
import '../../../feature/profile/bloc/profile_event.dart';
import '../../../feature/profile/bloc/profile_state.dart';
import '../../../feature/settings/inherited/theme_controller.dart';
import '../custom_next_button_widget.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final isLightMode = profileState.isLightMode;

        return Column(
          children: <Widget>[
            // SizedBox(height: 20.h),
            Column(
              children: [
                CustomThemePicker(
                  onSelect: () {
                    context.read<ProfileBloc>().add(SetLightMode(true));
                  },
                  mode: context.localized.white,
                  selected: isLightMode!,
                  color: AppColors.white,
                ),
                SizedBox(height: 8.h,),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 320,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h,),
                CustomThemePicker(
                  onSelect: () {
                    context.read<ProfileBloc>().add(SetLightMode(false));
                  },
                  mode: context.localized.black,
                  selected: !isLightMode,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomNextButtonWidget(
              text: context.localized.choose,
              onPressed: () {
                final themeCubit = context.read<ThemeCubit>();
                final isSelectedLightMode =
                    context.read<ProfileBloc>().state.isLightMode;
                themeCubit.setTheme(isSelectedLightMode!);
                debugPrint("isSelectedLightMode: $isSelectedLightMode");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
