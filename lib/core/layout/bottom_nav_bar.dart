import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int? currentIndex;
  final ValueChanged<int> onTap;

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required dynamic icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.secondaryContainer.withValues(
                        alpha: 0.6,
                      )
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: HugeIcon(icon: icon, size: 20.w, color: color),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.medium14.copyWith(
                fontSize: 10.sp,
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        child: Container(
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 20.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Group: Home & Ask AI
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavItem(
                    context: context,
                    index: 0,
                    icon: HugeIcons.strokeRoundedHome01,
                    label: 'Home',
                  ),
                  SizedBox(width: 12.w),
                  _buildNavItem(
                    context: context,
                    index: 1,
                    icon: HugeIcons.strokeRoundedChat,
                    label: 'Ask AI',
                  ),
                ],
              ),

              // Center gap for Floating Scanner Button
              SizedBox(width: 44.w),

              // Right Group: History & Profile
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavItem(
                    context: context,
                    index: 2,
                    icon: HugeIcons.strokeRoundedWorkHistory,
                    label: 'History',
                  ),
                  SizedBox(width: 12.w),
                  _buildNavItem(
                    context: context,
                    index: 3,
                    icon: HugeIcons.strokeRoundedUser,
                    label: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
