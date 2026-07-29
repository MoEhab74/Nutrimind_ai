import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/routing/router_shell.dart';
import 'package:nutrimind_ai/features/Auth/presentation/views/login_view.dart';
import 'package:nutrimind_ai/features/Auth/presentation/views/register_view.dart';
import 'package:nutrimind_ai/features/chat/presentation/views/chat_view.dart';
import 'package:nutrimind_ai/features/history/presentation/views/history_view.dart';
import 'package:nutrimind_ai/features/home/presentation/views/home_view.dart';
import 'package:nutrimind_ai/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:nutrimind_ai/features/profile/presentation/views/profile_view.dart';
import 'package:nutrimind_ai/features/splash/splash_view.dart';

abstract class AppRouter {
  static late final GoRouter router;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void setupRouter() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      // Check for the first time the user opens the app to show the onboarding screen
      // Check if user isLoggedIn or not before showing the login screen
      // If not logged in, show login, else show home screen
      initialLocation: AppRoutes.splash,
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          name: AppRoutes.splash,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: AppRoutes.onBoarding,
          name: AppRoutes.onBoarding,
          builder: (context, state) =>
              OnBoardingView(onFinish: () => router.go(AppRoutes.register)),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: AppRoutes.register,
          name: AppRoutes.register,
          builder: (context, state) => const RegisterView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              RouterShell(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.home,
                  name: AppRoutes.home,
                  builder: (context, state) => const HomeView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.chat,
                  name: AppRoutes.chat,
                  builder: (context, state) => const ChatView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.history,
                  name: AppRoutes.history,
                  builder: (context, state) => const HistoryView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profile,
                  builder: (context, state) => const ProfileView(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
