import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';

class DetailedBreakdownRow extends StatelessWidget {
  final String label;
  final String valueText;
  final double progress;
  final Color progressColor;

  const DetailedBreakdownRow({
    super.key,
    required this.label,
    required this.valueText,
    required this.progress,
    this.progressColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveProgressColor = progressColor == AppColors.primary ? colorScheme.primary : progressColor;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.medium14.copyWith(
                color: colorScheme.onSurface,
                fontSize: 13.sp,
              ),
            ),
            Text(
              valueText,
              style: AppTextStyles.semiBold12.copyWith(
                color: effectiveProgressColor == colorScheme.error ? colorScheme.error : colorScheme.outline,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        const AppSizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8.h,
            backgroundColor: colorScheme.surfaceContainer,
            color: effectiveProgressColor,
          ),
        ),
      ],
    );
  }

  void operator /(int other) {}
}