import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(height: 12.h),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: colorScheme.primaryContainer,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedBot,
                color: colorScheme.onPrimaryContainer,
                size: 40.w,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 10.r,
                backgroundColor: colorScheme.primary,
                child: Icon(
                  Icons.check_rounded,
                  color: colorScheme.onPrimary,
                  size: 12.w,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'NutriMind AI',
          style: AppTextStyles.semiBold28.copyWith(
            color: colorScheme.onSurface,
            fontSize: 22.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your AI Nutrition Assistant',
          style: AppTextStyles.regular16.copyWith(
            color: colorScheme.outline,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}