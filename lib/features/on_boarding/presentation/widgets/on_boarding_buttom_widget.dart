import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Bottom section of the onboarding screen: dots indicator + the
/// Next/Get Started button. Extracted so [OnboardingScreen] stays clean
/// and this row can be reused/tested on its own.
class OnboardingBottomWidget extends StatelessWidget {
  const OnboardingBottomWidget({
    super.key,
    required this.controller,
    required this.pagesCount,
    required this.isLastPage,
    required this.onPressed,
  });

  final PageController controller;
  final int pagesCount;
  final bool isLastPage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: pagesCount,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.surfaceHighest,
              dotHeight: 8.h,
              dotWidth: 8.w,
              expansionFactor: 3.0,
              spacing: 6.w,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                isLastPage ? 'Get Started' : 'Next',
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}