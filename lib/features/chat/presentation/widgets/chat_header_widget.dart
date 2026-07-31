import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: AppColors.primaryContainer,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedBot,
                color: AppColors.onPrimaryContainer,
                size: 40.w,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 10.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.onPrimary,
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
            color: AppColors.onBackground,
            fontSize: 22.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your AI Nutrition Assistant',
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.outline,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}