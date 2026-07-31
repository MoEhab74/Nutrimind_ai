import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class MealCardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final IconData? placeholderIcon;
  final bool isCompleted;
  final VoidCallback? onTap;

  const MealCardTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.placeholderIcon,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(20.r),
        border: !isCompleted ? Border.all(color: AppColors.border, style: BorderStyle.solid) : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 48.w,
                    height: 48.w,
                    color: AppColors.surfaceContainer,
                    child: Icon(
                      placeholderIcon ?? Icons.restaurant,
                      color: AppColors.outline,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.semiBold16.copyWith(color: AppColors.onSurface),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppTextStyles.regular16.copyWith(
                    color: isCompleted ? AppColors.outline : AppColors.outlineVariant,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              isCompleted ? Icons.check_circle : Icons.add_circle,
              color: isCompleted ? AppColors.primaryContainer : AppColors.primary,
              size: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}