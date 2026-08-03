import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_buttom.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_cubit.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_state.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/detailed_break_sown_row_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/health_score_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/nutri_mind_insight_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/nutrient_badge_card_widget.dart';

class ScanResultView extends StatelessWidget {
  final FoodModel foodModel;
  final XFile? image;

  const ScanResultView({super.key, required this.foodModel, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260.h,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: CircleAvatar(
                backgroundColor: AppColors.surfaceLowest.withValues(alpha: 0.8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.onSurface,
                    size: 20.w,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  image != null
                      ? image!.path.startsWith('http')
                            ? Image.network(image!.path, fit: BoxFit.cover)
                            : Image.file(File(image!.path), fit: BoxFit.cover)
                      : Image.network(
                          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=600',
                          fit: BoxFit.cover,
                        ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.h,
                    left: 20.w,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedCalendar01,
                              color: AppColors.onPrimary.withValues(alpha: 0.9),
                              size: 14.w,
                            ),
                            SizedBox(width: 4.w),
                            // I'll handle it according to time of the meal to detremine is it breakfast or lunch or dinner etc.
                            Text(
                              'Today, Oct 24  •  ',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.onPrimary,
                                fontSize: 12.sp,
                              ),
                            ),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedSun01,
                              color: AppColors.onPrimary.withValues(alpha: 0.9),
                              size: 14.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Lunch',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.onPrimary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          foodModel.name ?? 'Grilled Chicken with Rice',
                          style: AppTextStyles.semiBold28.copyWith(
                            color: AppColors.onPrimary,
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Content Detail
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Health Score + Macros Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HealthScoreCard(score: foodModel.healthScore ?? 0),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 1.35,
                          children: [
                            NutrientBadgeCard(
                              label: 'Calories',
                              value: '${foodModel.calories ?? 650}',
                            ),
                            NutrientBadgeCard(
                              label: 'Protein',
                              value: '${foodModel.protein ?? 45}g',
                              valueColor: AppColors.primary,
                              cardBgColor: AppColors.secondaryContainer
                                  .withValues(alpha: 0.4),
                            ),
                            NutrientBadgeCard(
                              label: 'Carbs',
                              value: '${foodModel.carbs ?? 65}g',
                            ),
                            NutrientBadgeCard(
                              label: 'Fat',
                              value: '${foodModel.fat ?? 12}g',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Insight Card
                  const NutriMindInsightCard(
                    insightText:
                        'Great choice! This meal is protein-packed. Add a side salad to increase fiber and hit your daily micronutrient goal.',
                  ),
                  SizedBox(height: 24.h),

                  // Detailed Breakdown Section
                  Text(
                    'Detailed Breakdown',
                    style: AppTextStyles.semiBold20.copyWith(
                      color: AppColors.onBackground,
                    ),
                  ),
                  const AppSizedBox(height: 16),
                  // Use food model to get the data.
                  DetailedBreakdownRow(
                    label: 'Fiber',
                    valueText: '${foodModel.fiber ?? 0}g / 10g',
                    progress: (foodModel.fiber ?? 0) / 10,
                    progressColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  DetailedBreakdownRow(
                    label: 'Sugar',
                    valueText: '${foodModel.sugar ?? 0}g / 5g',
                    progress: (foodModel.sugar ?? 0) / 5,
                    progressColor: AppColors.primaryContainer,
                  ),
                  SizedBox(height: 16.h),
                  DetailedBreakdownRow(
                    label: 'Sodium',
                    valueText: '${foodModel.sodium ?? 0}mg / 1000mg',
                    progress: (foodModel.sodium ?? 0) / 1000,
                    progressColor: AppColors.primaryContainer,
                  ),
                  SizedBox(height: 32.h),

                  //Interactive Buttons
                  BlocConsumer<MealCubit, MealState>(
                    listener: (context, state) async {
                      if (state is MealAddedSuccessfully) {
                        showAnimatedSnackbar(
                          context,
                          message: 'Meal added successfully',
                          type: AnimatedSnackBarType.success,
                        );
                        await context.read<HomeMealsCubit>().getAllMeals();
                        if (!context.mounted) return;
                        context.go(AppRoutes.home);
                      } else if (state is MealFailure) {
                        showAnimatedSnackbar(
                          context,
                          message: state.errorMessage,
                          type: AnimatedSnackBarType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is MealLoading;
                      return AppButton(
                        text: isLoading ? 'Adding Meal...' : 'Add to Diary',
                        icon: isLoading
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  color: AppColors.onPrimary,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.add_task_rounded),
                        onPressed: isLoading
                            ? () {}
                            : () {
                                if (image == null) {
                                  showAnimatedSnackbar(
                                    context,
                                    message: 'No meal image provided',
                                    type: AnimatedSnackBarType.error,
                                  );
                                  return;
                                }
                                // Convert FoodModel To MealModel
                                final mealModel = MealModel.fromFood(foodModel);
                                // Add Meal to ur diary
                                context
                                    .read<MealCubit>()
                                    .addMeal(mealModel, image!);
                              },
                      );
                    },
                  ),
                  const AppSizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52.h),
                      side: const BorderSide(color: AppColors.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedQrCode,
                          color: AppColors.onSurface,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Scan Again',
                          style: AppTextStyles.semiBold16.copyWith(
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AppSizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
