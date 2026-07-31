import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class MacroProgressCard extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color? cardBgColor;

  const MacroProgressCard({
    super.key,
    required this.label,
    required this.value,
    required this.progress,
    this.cardBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: cardBgColor ?? AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.outline,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: AppTextStyles.semiBold20.copyWith(color: AppColors.onSurface),
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4.h,
                backgroundColor: AppColors.surfaceContainer,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}