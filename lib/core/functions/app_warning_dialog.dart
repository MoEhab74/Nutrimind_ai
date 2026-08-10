import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';


void showAppWarningDialog(
  BuildContext context, {
  required String title,
  required String description,
  required String buttonText,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: colorScheme.errorContainer,
                child: Icon(
                  Icons.logout_rounded,
                  color: colorScheme.error,
                  size: 28.w,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                title,
                style: AppTextStyles.semiBold20.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular16.copyWith(
                  color: colorScheme.outline,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onCancel?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: BorderSide(color: colorScheme.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: colorScheme.onSurface,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: AppTextStyles.semiBold16.copyWith(
                          color: colorScheme.onError,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
