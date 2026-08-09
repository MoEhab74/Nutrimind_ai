import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final bool hasValidImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.r),
        border: !isCompleted
            ? Border.all(color: colorScheme.outlineVariant, style: BorderStyle.solid)
            : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: hasValidImage
                ? Image.network(
                    imageUrl!,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      log('Meal image load failed for URL ($imageUrl): $error');
                      return Container(
                        width: 48.w,
                        height: 48.w,
                        color: colorScheme.surfaceContainer,
                        child: Icon(
                          placeholderIcon ?? Icons.restaurant,
                          color: colorScheme.outline,
                        ),
                      );
                    },
                  )
                : Container(
                    width: 48.w,
                    height: 48.w,
                    color: colorScheme.surfaceContainer,
                    child: Icon(
                      placeholderIcon ?? Icons.restaurant,
                      color: colorScheme.outline,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular16.copyWith(
                    color: isCompleted
                        ? colorScheme.outline
                        : colorScheme.outlineVariant,
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
              color: isCompleted
                  ? colorScheme.primary
                  : colorScheme.primary,
              size: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}