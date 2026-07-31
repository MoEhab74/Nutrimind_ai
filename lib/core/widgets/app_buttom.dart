import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final OutlinedBorder? shape;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: shape ??
            (borderRadius != null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!.r),
                  )
                : null),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    AppTextStyles.semiBold16.copyWith(
                      color: textColor ?? AppColors.onPrimary,
                    ),
              ),
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: 8.w),
            icon!,
          ],
        ],
      ),
    );
  }
}