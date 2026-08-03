import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final isFirst = await getIt<OnboardingService>().isFirstVisit();
      if (!mounted) return;

      if (isFirst) {
        context.pushReplacement(AppRoutes.onBoarding);
      } else {
        // Check if user is authenticated in Firebase
        final user = getIt<FirebaseAuth>().currentUser;
        if (user != null) {
          // Check if profile setup has been completed (in Hive or Firestore)
          final isCompleted =
              await getIt<ProfileRepository>().isProfileCompleted();
          if (!mounted) return;
          if (isCompleted) {
            log('User Authenticated and profile is completed');
            context.pushReplacement(AppRoutes.home);
          } else {
            log('User Authenticated but profile is not completed');
            context.pushReplacement(AppRoutes.greeting);
          }
        } else {
          log('User not Authenticated');
          context.pushReplacement(AppRoutes.register);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.images.splash.path,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
