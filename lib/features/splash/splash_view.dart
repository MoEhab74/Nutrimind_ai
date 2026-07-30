import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
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
        context.pushReplacement(AppRoutes.register);
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
