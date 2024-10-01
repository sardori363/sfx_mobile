import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/widgets/theme_switch/theme_picker_widget.dart';

import '../../../../generated/assets.dart';

class ThemeButtonWidget extends StatelessWidget {
  const ThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: AppColors.yellow,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const CustomThemeWidget(),
        );
      },
      child: SvgPicture.asset(Assets.iconsSun),
    );
  }
}
