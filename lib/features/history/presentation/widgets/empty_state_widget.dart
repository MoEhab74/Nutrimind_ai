import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.icon,
    this.imagePath,
  });

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final IconData? icon;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. الأيقونة أو الصورة
              _buildIllustration(context),
              SizedBox(height: 24.h),

              // 2. العنوان الرئيسي
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold16.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),

              // 3. الرسالة التوضيحية
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 28.h),

              // 4. زر الإجراء
              SizedBox(
                width: double.infinity,
                height: 48.r,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: AppTextStyles.semiBold16.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        width: 140.r,
        height: 140.r,
        fit: BoxFit.contain,
      );
    }

    return Container(
      width: 100.r,
      height: 100.r,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon ?? Icons.inbox_rounded,
        size: 48.r,
        color: colorScheme.primary,
      ),
    );
  }
}