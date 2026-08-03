import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_buttom.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class GreetingStepBody extends StatelessWidget {
  final VoidCallback onStart;

  const GreetingStepBody({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const AppSizedBox(height: 12),
          // Top Illustration graphic card with soft green background shape & circle frame
          SizedBox(
            height: 240.h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Soft organic green shape on top right backdrop
                Positioned(
                  right: 20.w,
                  top: 0,
                  child: Container(
                    width: 90.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7F3D6).withValues(alpha: 0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                        bottomLeft: Radius.circular(50.r),
                      ),
                    ),
                  ),
                ),
                // Circular White Container
                Container(
                  width: 180.w,
                  height: 180.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24.r,
                        spreadRadius: 2.r,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Assets.images.onBoarding1.image(fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AppSizedBox(height: 24),
          // Category tag
          Text(
            'WELCOME TO NUTRIMIND',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.primary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const AppSizedBox(height: 8),
          // Headline
          Text(
            'Personalize Your Journey',
            style: AppTextStyles.semiBold24.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const AppSizedBox(height: 12),
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Let's tailor NutriMind AI to your unique body and health goals. A few moments now for a lifetime of clarity.",
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.outline,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const AppSizedBox(height: 32),
          // Feature Badges
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLow,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD3F5DD),
                          shape: BoxShape.circle,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedMicroscope,
                          color: AppColors.primary,
                          size: 22.r,
                        ),
                      ),
                      const AppSizedBox(height: 10),
                      Text(
                        'Data Driven',
                        style: AppTextStyles.medium14.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLow,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9E4F5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.spa_outlined,
                          color: const Color(0xFF4A607A),
                          size: 22.r,
                        ),
                      ),
                      const AppSizedBox(height: 10),
                      Text(
                        'Human Centric',
                        style: AppTextStyles.medium14.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const AppSizedBox(height: 36),
          // Dot progress indicator: 1 active pill + 5 dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              ...List.generate(
                5,
                (index) => Container(
                  width: 6.w,
                  height: 6.h,
                  margin: EdgeInsets.only(left: 6.w),
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceDim,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const AppSizedBox(height: 20),
          // Action Button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: AppButton(
              text: 'Begin Profile',
              icon: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
              backgroundColor: AppColors.primary,
              borderRadius: 26,
              onPressed: onStart,
            ),
          ),
          const AppSizedBox(height: 12),
          // Footnote
          Text(
            'Takes about 2 minutes',
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.outline,
              fontSize: 13.sp,
            ),
          ),
          const AppSizedBox(height: 16),
        ],
      ),
    );
  }
}
