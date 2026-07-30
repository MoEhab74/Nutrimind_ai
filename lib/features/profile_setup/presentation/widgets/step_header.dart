import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';

class StepHeader extends StatelessWidget {
  final String title;
  final String description;

  const StepHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold28.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const AppSizedBox(height: 8),
        Text(
          description,
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.outline,
          ),
        ),
        const AppSizedBox(height: 24),
      ],
    );
  }
}
