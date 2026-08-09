import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class AiTipCard extends StatelessWidget {
  final String tipText;

  const AiTipCard({
    super.key,
    required this.tipText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: colorScheme.primary,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedBulb,
              color: colorScheme.onPrimary,
              size: 18.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NUTRIMIND TIP',
                  style: AppTextStyles.semiBold12.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontSize: 10.sp,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  tipText,
                  style: AppTextStyles.regular16.copyWith(
                    color: colorScheme.onPrimaryContainer,
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