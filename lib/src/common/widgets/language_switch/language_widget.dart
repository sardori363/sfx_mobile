import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/common/widgets/custom_stick_widget.dart';

import '../../../../generated/assets.dart';
import 'custom_language_picker.dart';

class LanguageSelectionBottomSheetWidget extends StatelessWidget {
  const LanguageSelectionBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
        color: context.colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: <Widget>[
            const CustomStickWidget(),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                Text(
                  context.localized.choose_lang,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontSize: 20.sp,
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: SvgPicture.asset(
                    Assets.iconsRoundClose,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
            SizedBox(height: 10.h,),
            const CustomLanguagePickerWidget(),
          ],
        ),
      ),
    );
  }
}
