import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutrimind_ai/core/api/api_endpoints.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/routing/app_router.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/notification_service.dart';
import 'package:nutrimind_ai/core/theme/themes/app_themes.dart';
import 'package:nutrimind_ai/core/theme/themes/manager/theme_cubit.dart';
import 'package:nutrimind_ai/core/theme/themes/manager/theme_state.dart';
import 'package:nutrimind_ai/core/utils/app_constants.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Make sure that everything is ready before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetIt service dependencies
  setupGetIt();
  // Initialize .env
  await dotenv.load(fileName: ".env");
  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize notification service
  await getIt.get<NotificationService>().initialize();

  // Initialize Supabase
  await Supabase.initialize(
    url: ApiEndpoints.supabaseUrl,
    publishableKey: ApiKeys.supabaseAnonKey,
  );
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileSetupModelAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(ActivityLevelAdapter());
  await Hive.openBox<ProfileSetupModel>('profile');

  // Initialize the router
  AppRouter.setupRouter();
  // Initialize cache helper
  await getIt.get<CacheHelper>().initCacheHelper();

  // Theme
  final themeCubit = getIt.get<ThemeCubit>();
  themeCubit.loadSavedTheme();

  runApp(BlocProvider(create: (context) => themeCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final themeMode = state is ThemeLoaded
                ? state.themeMode
                : context.read<ThemeCubit>().themeMode;
            return MaterialApp.router(
              title: AppConstants.appName,
              routerConfig: AppRouter.router,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
