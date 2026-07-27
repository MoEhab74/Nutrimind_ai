import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/routing/app_router.dart';
import 'package:nutrimind_ai/core/theme/themes/app_themes.dart';
import 'package:nutrimind_ai/core/utils/app_constants.dart';

void main() {
  // Make sure that everything is ready before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the router
  AppRouter.setupRouter();
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
