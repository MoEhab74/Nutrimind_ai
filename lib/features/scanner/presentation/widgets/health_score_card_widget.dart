import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';

class HealthScoreCard extends StatelessWidget {
  final int score;
  final int maxScore;

  const HealthScoreCard({
    super.key,
    required this.score,
    this.maxScore = 100,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (score / maxScore).clamp(0.0, 1.0);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 90.r,
                  height: 90.r,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 9.w,
                    backgroundColor: colorScheme.surfaceContainer,
                    color: colorScheme.primary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score',
                      style: AppTextStyles.semiBold28.copyWith(
                        color: colorScheme.onSurface,
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      '/$maxScore',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: colorScheme.outline,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const AppSizedBox(height: 12),
          Text(
            'Health Score',
            style: AppTextStyles.medium14.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}