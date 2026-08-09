import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/routing/router_shell.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/Auth/presentation/views/login_view.dart';
import 'package:nutrimind_ai/features/Auth/presentation/views/register_view.dart';
import 'package:nutrimind_ai/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:nutrimind_ai/features/chat/presentation/views/chat_view.dart';
import 'package:nutrimind_ai/features/history/presentation/manager/cubit/history_cubit.dart';
import 'package:nutrimind_ai/features/history/presentation/views/history_view.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/views/home_view.dart';
import 'package:nutrimind_ai/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:nutrimind_ai/features/profile/presentation/manager/profile_cubit.dart';
import 'package:nutrimind_ai/features/profile/presentation/views/profile_view.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/views/greeting_view.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/views/profile_setup_view.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/views/scan_result_view.dart';
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
          builder: (context, state) => OnBoardingView(
            onFinish: () {
              // Mark onboarding as completed
              getIt<OnboardingService>().completeOnboarding();
              // Navigate to register screen
              router.go(AppRoutes.register);
            },
          ),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.register,
          name: AppRoutes.register,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const RegisterView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.greeting,
          name: AppRoutes.greeting,
          builder: (context, state) => const GreetingView(),
        ),
        GoRoute(
          path: AppRoutes.profileSetup,
          name: AppRoutes.profileSetup,
          builder: (context, state) => const ProfileSetupView(),
        ),
        GoRoute(
          path: AppRoutes.scanResult,
          name: AppRoutes.scanResult,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is Map<String, dynamic>) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<MealCubit>()),
                  BlocProvider.value(value: getIt<HomeMealsCubit>()),
                  BlocProvider.value(
                    value: getIt<HistoryMealsCubit>()
                      ..getAllMealsOrderedByMealDate(),
                  ),
                ],
                child: ScanResultView(
                  foodModel: extra['foodModel'] as FoodModel,
                  image: extra['image'] as XFile?,
                ),
              );
            } else if (extra is FoodModel) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<MealCubit>()),
                  BlocProvider.value(value: getIt<HomeMealsCubit>()),
                ],
                child: ScanResultView(foodModel: extra),
              );
            }
            // Default to empty state or throw error if data is missing
            return const Scaffold(
              body: Center(child: Text('No food data available')),
            );
          },
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
                  builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt<HomeCubit>()..getNutrition(),
                      ),
                      BlocProvider.value(
                        value: getIt<HomeMealsCubit>()..getAllMeals(),
                      ),
                    ],
                    child: const HomeView(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.chat,
                  name: AppRoutes.chat,
                  builder: (context, state) => BlocProvider(
                    create: (context) => getIt<ChatCubit>(),
                    child: const ChatView(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.history,
                  name: AppRoutes.history,
                  builder: (context, state) => BlocProvider(
                    create: (context) =>
                        getIt<HistoryMealsCubit>()
                          ..getAllMealsOrderedByMealDate(),
                    child: const HistoryView(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profile,
                  builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            getIt<ProfileCubit>()..getUserData(),
                      ),
                      BlocProvider.value(value: getIt<AuthCubit>()),
                    ],
                    child: const ProfileView(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
