// import "package:flutter/widgets.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:play_arena/src/feature/settings/inherited/theme_controller.dart";
//
// @immutable
// class InheritedThemeCubit extends InheritedWidget {
//   const InheritedThemeCubit({
//     required this.themeCubit,
//     required super.child,
//     super.key,
//   });
//
//   final ThemeCubit themeCubit;
//
//   static ThemeCubit? maybeOf(BuildContext context, {bool listen = true}) {
//     if (listen) {
//       return BlocProvider.of<ThemeCubit>(context, listen: true);
//     } else {
//       final inheritedWidget = context
//           .getElementForInheritedWidgetOfExactType<InheritedThemeCubit>()
//           ?.widget;
//       return inheritedWidget is InheritedThemeCubit
//           ? inheritedWidget.themeCubit
//           : null;
//     }
//   }
//
//   @override
//   bool updateShouldNotify(covariant InheritedThemeCubit oldWidget) {
//     return oldWidget.themeCubit != themeCubit;
//   }
// }
