import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/greeting_step_body.dart';

class GreetingView extends StatelessWidget {
  const GreetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: GreetingStepBody(
            onStart: () {
              context.pushReplacement(AppRoutes.profileSetup);
            },
          ),
        ),
      ),
    );
  }
}
