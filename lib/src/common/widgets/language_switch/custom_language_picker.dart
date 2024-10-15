import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/bloc/local_cubit.dart';
import 'package:sfx/src/feature/init/bloc/splash_bloc.dart';
import 'package:sfx/src/feature/init/bloc/splash_event.dart';
import 'package:sfx/src/feature/init/bloc/splash_state.dart';

import '../../../../generated/assets.dart';
import '../custom_next_button_widget.dart';
import 'language_picker_widget.dart';

class CustomLanguagePickerWidget extends StatelessWidget {
  const CustomLanguagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String currentLang = "";
    return Column(
      children: <Widget>[
        // SizedBox(height: 20.h),
        BlocBuilder<SplashPageBloc, SplashPageState>(
          builder: (_, state) {
            return Column(
              children: [
                CustomEachLanguagePickerWidget(
                  onSelect: () {
                    currentLang = "uz";
                    context
                        .read<SplashPageBloc>()
                        .add(const ChangeCurrentLanguage("uz"));
                  },
                  language: "O'zbek tili",
                  selected:
                      state.currentLanguage == const Locale("uz").toString(),
                  countryFlag: Assets.imagesFlagUzb,
                ),
                SizedBox(height: 8.h,),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    height: 1.h,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h,),
                CustomEachLanguagePickerWidget(
                  onSelect: () {
                    currentLang = "ru";
                    context
                        .read<SplashPageBloc>()
                        .add(const ChangeCurrentLanguage("ru"));
                  },
                  language: "Русский",
                  selected:
                      state.currentLanguage == const Locale("ru").toString(),
                  countryFlag: Assets.imagesFlagRus,
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        // const Spacer(),
        CustomNextButtonWidget(
          text: "Tanlash",
          onPressed: () {
            Navigator.pop(context);
            context.read<LocaleCubit>().changeLocale(
                  Locale(currentLang, currentLang.toUpperCase()),
                );
          },
        ),
      ],
    );
  }
}
