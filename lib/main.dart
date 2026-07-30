import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/routing/app_router.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/theme/themes/app_themes.dart';
import 'package:nutrimind_ai/core/utils/app_constants.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/firebase_options.dart';

void main() async {
  // Make sure that everything is ready before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileSetupModelAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(ActivityLevelAdapter());
  await Hive.openBox<ProfileSetupModel>('profile');

  // Initialize the router
  AppRouter.setupRouter();
  // Initialize the get it service
  setupGetIt();
  // Initialize cache helper
  await getIt.get<CacheHelper>().initCacheHelper();
  // clear the profile from hive box to test again
  // await Hive.box<ProfileSetupModel>('profile').clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          routerConfig: AppRouter.router,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
