import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

void showAnimatedSnackbar(
  BuildContext context, {
  required String message,
  AnimatedSnackBarType type = AnimatedSnackBarType.success,
}) {
  final (backgroundColor, iconData) = switch (type) {
    AnimatedSnackBarType.success => (AppColors.primary, Icons.check_circle_outline),
    AnimatedSnackBarType.error => (AppColors.error, Icons.error_outline),
    AnimatedSnackBarType.info => (AppColors.secondary, Icons.info_outline),
    AnimatedSnackBarType.warning => (const Color(0xFFE67E22), Icons.warning_amber_rounded),
  };

  AnimatedSnackBar.removeAll();

  AnimatedSnackBar(
    duration: const Duration(seconds: 4),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColors.onPrimary,
              size: 22.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.medium14.copyWith(
                  color: AppColors.onPrimary,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).show(context);
}