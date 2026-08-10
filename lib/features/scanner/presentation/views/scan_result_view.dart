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
import 'package:nutrimind_ai/features/history/presentation/manager/cubit/history_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_cubit.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_state.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/detailed_break_sown_row_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/health_score_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/nutri_mind_insight_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/nutrient_badge_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/scan_again_outlined_button_widget.dart';

class ScanResultView extends StatelessWidget {
  final FoodModel foodModel;
  final XFile? image;

  const ScanResultView({super.key, required this.foodModel, this.image});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 56.w,
            expandedHeight: 260.h,
            pinned: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            leading: Center(
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorScheme.onSurface,
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
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const AppSizedBox(height: 16),
                  // Use food model to get the data.
                  DetailedBreakdownRow(
                    label: 'Fiber',
                    valueText: '${foodModel.fiber ?? 0}g / 10g',
                    progress: (foodModel.fiber ?? 0) / 10,
                    progressColor: colorScheme.primary,
                  ),
                  SizedBox(height: 16.h),
                  DetailedBreakdownRow(
                    label: 'Sugar',
                    valueText: '${foodModel.sugar ?? 0}g / 5g',
                    progress: (foodModel.sugar ?? 0) / 5,
                    progressColor: colorScheme.primaryContainer,
                  ),
                  SizedBox(height: 16.h),
                  DetailedBreakdownRow(
                    label: 'Sodium',
                    valueText: '${foodModel.sodium ?? 0}mg / 1000mg',
                    progress: (foodModel.sodium ?? 0) / 1000,
                    progressColor: colorScheme.primaryContainer,
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
                        // Trigger history method from history cubit to update meals list in HistoryView
                        await context
                            .read<HistoryMealsCubit>()
                            .getAllMealsOrderedByMealDate();
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
                                child: CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
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
                                context.read<MealCubit>().addMeal(
                                  mealModel,
                                  image!,
                                );
                              },
                      );
                    },
                  ),
                  const AppSizedBox(height: 12),
                  ScanAgainOutlinedButton(colorScheme: colorScheme),
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

