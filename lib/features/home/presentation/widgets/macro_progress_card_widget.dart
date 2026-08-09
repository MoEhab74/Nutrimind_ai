import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: cardBgColor ?? colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: AppTextStyles.semiBold12.copyWith(
                color: colorScheme.outline,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: AppTextStyles.semiBold20.copyWith(color: colorScheme.onSurface),
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4.h,
                backgroundColor: colorScheme.surfaceContainer,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}