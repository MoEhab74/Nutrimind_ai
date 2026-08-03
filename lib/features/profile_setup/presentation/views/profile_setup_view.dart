import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/widgets/app_buttom.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/manager/profile_setup_cubit.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/manager/profile_setup_state.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/step_progress_bar.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/about_you_body.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/activity_step_body.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/goal_step_body.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/review_step_body.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/steps/vitals_step_body.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileSetupCubit>(),
      child: const ProfileSetupViewBody(),
    );
  }
}

class ProfileSetupViewBody extends StatelessWidget {
  const ProfileSetupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileSetupCubit.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
            builder: (context, state) {
              final isLastStep = state.currentStep == 4;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepProgressBar(
                    currentStep: state.currentStep + 1,
                    totalSteps: 5,
                    progressPercent: (state.currentStep + 1) / 5.0,
                  ),
                  const AppSizedBox(height: 24),
                  Expanded(
                    child: PageView(
                      controller: cubit.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // About You Step
                        AboutYouBody(
                          selectedSex: state.profile.gender ?? Gender.female,
                          age: state.profile.age ?? 28,
                          onSexSelected: cubit.updateGender,
                          onAgeIncrement: () =>
                              cubit.updateAge((state.profile.age ?? 28) + 1),
                          onAgeDecrement: () {
                            final currentAge = state.profile.age ?? 28;
                            if (currentAge > 1) {
                              cubit.updateAge(currentAge - 1);
                            }
                          },
                        ),
                        // Goal Step
                        GoalStepBody(
                          selectedGoal: state.profile.goal ?? Goal.loseWeight,
                          targetWeight: state.profile.targetWeight ?? 65.0,
                          onGoalChanged: cubit.updateGoal,
                          onTargetWeightChanged: cubit.updateTargetWeight,
                        ),
                        // Vitals Step
                        VitalsStepBody(
                          height: state.profile.height ?? 170.0,
                          weight: state.profile.weight ?? 70.0,
                          onHeightChanged: cubit.updateHeight,
                          onWeightChanged: cubit.updateWeight,
                        ),
                        // Activity Step
                        ActivityStepBody(
                          selectedActivity:
                              state.profile.activity ??
                              ActivityLevel.moderatelyActive,
                          onActivityChanged: cubit.updateActivity,
                        ),
                        // Review Step
                        ReviewStepBody(
                          profile: state.profile,
                          onEditStep: cubit.goToStep,
                        ),
                      ],
                    ),
                  ),
                  const AppSizedBox(height: 16),
                  Row(
                    children: [
                      if (state.currentStep > 0) ...[
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            text: 'Back',
                            backgroundColor: AppColors.surfaceContainer,
                            textColor: AppColors.onSurface,
                            onPressed: cubit.previousStep,
                          ),
                        ),
                        SizedBox(width: 12.w),
                      ],
                      state is ProfileSetupLoading
                          ? const Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Expanded(
                              flex: 2,
                              child: AppButton(
                                text: isLastStep
                                    ? 'Complete Profile'
                                    : 'Continue',
                                icon: isLastStep
                                    ? const Icon(Icons.check_circle_outline)
                                    : const Icon(Icons.arrow_forward),
                                onPressed: () async {
                                  if (isLastStep) {
                                    await cubit.saveProfile();
                                    if (context.mounted) {
                                      context.pushReplacement(AppRoutes.home);
                                    }
                                    log('Profile Setup Completed');
                                  } else {
                                    cubit.nextStep();
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
