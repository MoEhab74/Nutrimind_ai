import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double progressPercent;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.progressPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STEP $currentStep OF $totalSteps',
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '${(progressPercent * 100).toInt()}% Complete',
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progressPercent,
            minHeight: 6.h,
            backgroundColor: AppColors.surfaceContainer,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}