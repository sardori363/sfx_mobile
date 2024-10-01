import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/src/feature/home/widgets/custom_button.dart';

import '../../feature/main/bloc/bottom_nav.dart';
import '../routing/app_route_name.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          icon: Icons.arrow_back_outlined,
          onPressed: () {
            try {
              context.pop(context);
            } catch (e) {
              BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(0);
              context.push(AppRouteName.homePage);
            }
          },
        ),
      ],
    );
  }
}
