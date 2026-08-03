import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';

class NutriMindInsightCard extends StatelessWidget {
  final String insightText;

  const NutriMindInsightCard({
    super.key,
    required this.insightText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.primaryContainer,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSparkles,
              color: AppColors.onPrimaryContainer,
              size: 18.w,
            ),
          ),
          const AppSizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NutriMind Insight',
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.onSecondaryContainer,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  insightText,
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13.sp,
                    height: 1.4,
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