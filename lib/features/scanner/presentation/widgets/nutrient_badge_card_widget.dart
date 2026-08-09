import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';

class NutrientBadgeCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final Color? cardBgColor;

  const NutrientBadgeCard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.cardBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: cardBgColor ?? colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.semiBold12.copyWith(
              color: colorScheme.outline,
              fontSize: 11.sp,
            ),
          ),
          const AppSizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: AppTextStyles.semiBold20.copyWith(
                color: valueColor ?? colorScheme.onSurface,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}