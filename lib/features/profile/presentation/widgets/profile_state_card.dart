import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ProfileStatCard extends StatelessWidget {
  final String? tag;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Widget? extraWidget;

  const ProfileStatCard({
    super.key,
    this.tag,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.backgroundColor = AppColors.surfaceLow,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.primary, size: 22.w),
              if (tag != null)
                Text(
                  tag!,
                  style: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: AppTextStyles.semiBold20.copyWith(
                  color: AppColors.onSurface,
                ),
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (subtitle.isNotEmpty)
                Flexible(
                  child: Text(
                    subtitle,
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              extraWidget ?? const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}