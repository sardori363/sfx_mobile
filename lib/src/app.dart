import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/bloc/auth_checker_bloc.dart';
import 'package:sfx/src/common/routing/app_router.dart';
import 'package:sfx/src/feature/home/bloc/home_bloc.dart';

import 'package:sfx/src/feature/profile/bloc/profile_bloc.dart';
import 'common/bloc/internet_connectivity_bloc.dart';
import 'common/bloc/local_cubit.dart';
import 'common/l10n/l10n.dart';
import 'feature/init/bloc/splash_bloc.dart';
import 'feature/main/bloc/bottom_nav.dart';
import 'feature/otp/bloc/otp_bloc.dart';
import 'feature/settings/inherited/theme_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) : builderKey = GlobalKey();

  final GlobalKey builderKey;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BottomNavCubit()),
            BlocProvider(create: (context) => SplashPageBloc()),
            BlocProvider(
              create: (context) => ConnectivityBloc(
                connectivity: Connectivity(),
              ),
            ),
            BlocProvider(create: (context) => LocaleCubit()),
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => OtpBloc()),
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => ProfileBloc()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              return BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    onGenerateTitle: (BuildContext context) => "SFX",
                    supportedLocales: L10n.all,
                    theme: theme,
                    locale: locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      return supportedLocales.firstWhere(
                        (locale) =>
                            locale.languageCode == deviceLocale?.languageCode,
                        orElse: () => const Locale('uz'),
                      );
                    },
                    routerConfig: AppRouter.router,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery.withNoTextScaling(
                        key: builderKey,
                        child: child ?? const SizedBox.shrink(),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

// final _splashVisitedNotifier = ValueNotifier(false);
//
// MyApp({super.key}) {
//   _initSplashVisitedFlag();
// }
//
// Future<void> _initSplashVisitedFlag() async {
//   final splashVisited = await AppStorage.$read(key: StorageKey.splashVisited);
//   if (splashVisited != null) {
//     _splashVisitedNotifier.value = splashVisited == 'true';
//   }
// }
