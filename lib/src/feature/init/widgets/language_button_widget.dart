import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sfx/src/common/styles/app_colors.dart';

import '../../../../generated/assets.dart';
import '../../../common/widgets/language_switch/language_widget.dart';

class LanguageButtonWidget extends StatelessWidget {
  const LanguageButtonWidget({super.key});

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
          builder: (context) => const LanguageSelectionBottomSheetWidget(),
        );
      },
      child: SvgPicture.asset(Assets.iconsGlobe),
    );
  }
}
