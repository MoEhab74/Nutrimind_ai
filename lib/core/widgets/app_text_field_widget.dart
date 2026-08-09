import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.medium14.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          style: AppTextStyles.regular16.copyWith(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.regular16.copyWith(color: colorScheme.outlineVariant),
            prefixIcon: Icon(prefixIcon, color: colorScheme.outline, size: 20.w),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: colorScheme.outline, size: 20.w)
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}