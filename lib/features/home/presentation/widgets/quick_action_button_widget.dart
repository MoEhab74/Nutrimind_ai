import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceLow,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.secondaryContainer.withValues(
                  alpha: 0.5,
                ),
                child: Icon(icon, color: AppColors.primary, size: 20.w),
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: AppTextStyles.medium14.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
