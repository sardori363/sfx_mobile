import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/feature/home/pages/home_page.dart';
import 'package:sfx/src/feature/home/pages/homework_details_page.dart';
import 'package:sfx/src/feature/home/pages/success_page.dart';
import 'package:sfx/src/feature/init/splash_screen.dart';
import 'package:sfx/src/feature/main/main_wrapper.dart';
import 'package:sfx/src/feature/otp/otp_input_page.dart';
import 'package:sfx/src/feature/otp/otp_page.dart';
import 'package:sfx/src/feature/profile/profile_page.dart';
import 'package:sfx/src/feature/tests/tests_page.dart';

import '../../setup.dart';
import 'app_route_name.dart';


@immutable
class AppRouter {
  factory AppRouter() => _router;

  const AppRouter._internal();

  static const AppRouter _router = AppRouter._internal();

  static final GoRouter router = GoRouter(
    initialLocation: token == null ? AppRouteName.splashPage : AppRouteName.homePage,
    // initialLocation: AppRouteName.homeworkDetailsPage,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        name: "InitialPage",
        path: AppRouteName.splashPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        name: "OTPPage",
        path: AppRouteName.otpPage,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpPage();
        },
      ),
      GoRoute(
        name: "OTPInputPage",
        path: AppRouteName.otpInputPage,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpInputPage();
        },
      ),
      GoRoute(
        name: "SuccessPage",
        path: AppRouteName.successPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SuccessPage();
        },
      ),
      GoRoute(
        name: "HWDetailsPage",
        path: AppRouteName.homeworkDetailsPage,
        builder: (BuildContext context, GoRouterState state) {
          final TaskWStatus? task = state.extra as TaskWStatus?;
          if (task != null) {
            log('Navigating to ArenaDetailsPage with arena: ${task.title}');
          } else {
            log('Arena object is null');
          }
          return HomeWorkDetailsPage(currentTask: task!,);
        },
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainWrapper(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: "HomePage",
            path: AppRouteName.homePage,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [],
          ),
          GoRoute(
            name: "TestsPage",
            path: AppRouteName.testsPage,
            builder: (BuildContext context, GoRouterState state) {
              return const TestsPage();
            },
          ),
          GoRoute(
            name: "ProfilePage",
            path: AppRouteName.profilePage,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),
        ],
      ),
    ],
  );
}

//
// @immutable
// final class BlockedRouter {
//   factory BlockedRouter() => _router;
//
//   const BlockedRouter._internal();
//
//   static const BlockedRouter _router = BlockedRouter._internal();
//
//   static final GoRouter router = GoRouter(
//     initialLocation: AppRouteName.blockedPage,
//     debugLogDiagnostics: true,
//     routes: <RouteBase>[
//       GoRoute(
//         name: "BlockedPage",
//         path: AppRouteName.blockedPage,
//         builder: (BuildContext context, GoRouterState state) {
//           return const Scaffold(
//             body: Center(
//               child: Text("App is permanently blocked !!!"),
//             ),
//           );
//         },
//       ),
//     ],
//   );
// }
