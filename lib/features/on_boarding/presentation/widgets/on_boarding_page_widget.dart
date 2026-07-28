import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/on_boarding/data/on_boarding_model.dart';
import 'package:nutrimind_ai/features/on_boarding/presentation/widgets/split_highlight_text_widget.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({super.key, required this.model});

  final BoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(model.image, fit: BoxFit.contain),
            ),
          ),
          const AppSizedBox(height: 32),
          SplitHighlightText(
            text: model.title,
            textAlign: TextAlign.center,
            highlightAfterWordCount: 3,
            style: AppTextStyles.semiBold28.copyWith(
              fontSize: 26.sp,
              color: AppColors.onSurface,
            ),
            highlightStyle: AppTextStyles.semiBold28.copyWith(
              fontSize: 26.sp,
              color: AppColors.primary,
            ),
          ),
          const AppSizedBox(height: 12),
          Text(
            model.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular16.copyWith(
              height: 1.5,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
