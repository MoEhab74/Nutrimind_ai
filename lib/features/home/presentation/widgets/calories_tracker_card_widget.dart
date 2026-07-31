import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
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
                    backgroundColor: AppColors.surfaceContainer,
                    color: AppColors.primary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$kcalLeft',
                      style: AppTextStyles.bold40.copyWith(
                        color: AppColors.onSurface,
                        fontSize: 32.sp,
                      ),
                    ),
                    Text(
                      'KCAL LEFT',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: AppColors.outline,
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
              style: AppTextStyles.regular16.copyWith(color: AppColors.outline),
              children: [
                const TextSpan(text: 'Daily Target: '),
                TextSpan(
                  text: '$dailyTarget kcal',
                  style: AppTextStyles.semiBold16.copyWith(color: AppColors.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}