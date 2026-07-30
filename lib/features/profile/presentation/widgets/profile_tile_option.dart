import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ProfileTileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? isDangerColor;

  const ProfileTileOption({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.isDangerColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDangerColor ?? AppColors.onSurface;
    final iconColor = isDangerColor ?? AppColors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium14.copyWith(
                  color: textColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}