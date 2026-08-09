import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class MealCardWidget extends StatelessWidget {
  final MealModel mealModel;
  final VoidCallback? onTap;

  const MealCardWidget({super.key, required this.mealModel, this.onTap});

  String _formatMealDate(DateTime date) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final timeStr = DateFormat('h:mm a').format(date);
    if (isToday) {
      return 'Today, $timeStr';
    } else {
      return '${DateFormat('MMM d').format(date)}, $timeStr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                child: Image.network(
                  mealModel.mealImageUrl,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160.h,
                    color: colorScheme.surfaceContainer,
                    child: Icon(
                      Icons.restaurant,
                      color: colorScheme.outline,
                      size: 40.w,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            mealModel.mealName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.semiBold16.copyWith(
                              color: colorScheme.onSurface,
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${mealModel.mealCalories} kcal',
                          style: AppTextStyles.semiBold20.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedClock01,
                              color: colorScheme.outline,
                              size: 16.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _formatMealDate(mealModel.mealDate),
                              style: AppTextStyles.medium14.copyWith(
                                color: colorScheme.outline,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'KCAL',
                          style: AppTextStyles.semiBold12.copyWith(
                            color: colorScheme.outline,
                            fontSize: 10.sp,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
