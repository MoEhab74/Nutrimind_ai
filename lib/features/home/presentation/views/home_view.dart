import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/top_app_bar.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_state.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/ai_tip_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/calories_tracker_card_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/macro_progress_card_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/meal_card_tile_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/quick_action_button_widget.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/scan_cubit/scan_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/choose_bottom_sheet_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getNutrition();
    context.read<HomeCubit>().getUserData();
    context.read<HomeMealsCubit>().getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TopAppBar(title: 'Home'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, homeState) {
              final fullName = homeState.userModel?.fullName;
              final greetingText = (fullName != null && fullName.isNotEmpty)
                  ? 'Hola $fullName! 👋'
                  : 'Hola Amigo! 👋';

              return BlocBuilder<HomeMealsCubit, HomeMealsState>(
                builder: (context, mealsState) {
                  final List<MealModel> meals = mealsState is HomeMealsSuccess
                      ? mealsState.meals
                      : context.watch<HomeMealsCubit>().meals;

                  // Sum up nutrients from all meals
                  int totalCalories = 0;
                  int totalProtein = 0;
                  int totalCarbs = 0;
                  int totalFat = 0;

                  for (final meal in meals) {
                    totalCalories += meal.mealCalories;
                    totalProtein += meal.mealProtein;
                    totalCarbs += meal.mealCarbs;
                    totalFat += meal.mealFat;
                  }

                  final int dailyTarget =
                      homeState.nutritionModel?.calories ?? 2000;
                  final int kcalLeft = (dailyTarget - totalCalories).clamp(
                    0,
                    dailyTarget,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      Text(
                        greetingText,
                        style: AppTextStyles.semiBold28.copyWith(
                          color: AppColors.onBackground,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Stay healthy and mindful today.',
                        style: AppTextStyles.regular16.copyWith(
                          color: AppColors.outline,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Calories Tracker Card
                      homeState.nutritionStatus == HomeStatus.loading ||
                              homeState.nutritionStatus == HomeStatus.initial
                          ? const Center(child: CircularProgressIndicator())
                          : homeState.nutritionStatus == HomeStatus.success &&
                                homeState.nutritionModel != null
                          ? CalorieTrackerCard(
                              kcalLeft: kcalLeft,
                              dailyTarget: dailyTarget,
                            )
                          : Center(
                              child: Text(
                                homeState.nutritionErrorMessage ??
                                    'Error loading nutrition',
                              ),
                            ),
                      SizedBox(height: 20.h),

                      // Quick Actions
                      Row(
                        children: [
                          QuickActionButton(
                            label: 'Scan',
                            icon: Icons.qr_code,
                            onTap: () {
                              // Show bottom sheet with options to scan or upload
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ScanCubit>(),
                                  child: const ChooseBottomSheetWidget(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 12.w),
                          QuickActionButton(
                            label: 'Ask AI',
                            icon: Icons.smart_toy_outlined,
                            onTap: () {
                              context.go(AppRoutes.chat);
                            },
                          ),
                          SizedBox(width: 12.w),
                          QuickActionButton(
                            label: 'History',
                            icon: Icons.history_outlined,
                            onTap: () {
                              context.go(AppRoutes.history);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Today's Meals Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today\'s Meals',
                            style: AppTextStyles.semiBold20.copyWith(
                              color: AppColors.onBackground,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(AppRoutes.history);
                            },
                            child: Text(
                              'View All',
                              style: AppTextStyles.medium14.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      // Today's Meals List
                      if (mealsState is HomeMealsLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (meals.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLowest,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Center(
                            child: Text(
                              'No meals added yet today. Tap Scan to add!',
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.outline,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        )
                      else
                        ...meals.map(
                          (meal) => MealCardTile(
                            title: meal.mealName,
                            subtitle: '${meal.mealCalories} kcal • Logged',
                            imageUrl: meal.mealImageUrl.isNotEmpty
                                ? meal.mealImageUrl
                                : null,
                            isCompleted: true,
                          ),
                        ),
                      SizedBox(height: 24.h),

                      // Daily Macros
                      Text(
                        'Daily Macros',
                        style: AppTextStyles.semiBold20.copyWith(
                          color: AppColors.onBackground,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          MacroProgressCard(
                            label: 'Protein',
                            value: '${totalProtein}g',
                            progress: (totalProtein / 120).clamp(0.0, 1.0),
                          ),
                          SizedBox(width: 10.w),
                          MacroProgressCard(
                            label: 'Carbs',
                            value: '${totalCarbs}g',
                            progress: (totalCarbs / 250).clamp(0.0, 1.0),
                            cardBgColor: AppColors.secondaryContainer
                                .withValues(alpha: 0.3),
                          ),
                          SizedBox(width: 10.w),
                          MacroProgressCard(
                            label: 'Fat',
                            value: '${totalFat}g',
                            progress: (totalFat / 65).clamp(0.0, 1.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      const AiTipCard(
                        tipText:
                            'Drink one more glass of water and add roasted vegetables to your dinner to reach your fiber goal.',
                      ),
                      SizedBox(height: 80.h),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
