import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class CalorieTrackerCard extends StatelessWidget {
  final int kcalLeft;
  final int dailyTarget;

  const CalorieTrackerCard({
    super.key,
    required this.kcalLeft,
    required this.dailyTarget,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (dailyTarget - kcalLeft) / dailyTarget;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 140.r,
            height: 140.r,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140.r,
                  height: 140.r,
                  child: CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 12.w,
                    backgroundColor: colorScheme.surfaceContainer,
                    color: colorScheme.primary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$kcalLeft',
                      style: AppTextStyles.bold40.copyWith(
                        color: colorScheme.onSurface,
                        fontSize: 32.sp,
                      ),
                    ),
                    Text(
                      'KCAL LEFT',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: colorScheme.outline,
                        fontSize: 10.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
              style: AppTextStyles.regular16.copyWith(color: colorScheme.outline),
              children: [
                const TextSpan(text: 'Daily Target: '),
                TextSpan(
                  text: '$dailyTarget kcal',
                  style: AppTextStyles.semiBold16.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
