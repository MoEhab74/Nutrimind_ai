import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/top_app_bar.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/ai_tip_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/calories_tracker_card_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/macro_progress_card_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/meal_card_tile_widget.dart';
import 'package:nutrimind_ai/features/home/presentation/widgets/quick_action_button_widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TopAppBar(title: 'Home'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final fullName = state.userModel?.fullName;
              final greetingText = (fullName != null && fullName.isNotEmpty)
                  ? 'Hola $fullName! 👋'
                  : 'Hola Amigo! 👋';

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
                  state.nutritionStatus == HomeStatus.loading ||
                          state.nutritionStatus == HomeStatus.initial
                      ? const Center(child: CircularProgressIndicator())
                      : state.nutritionStatus == HomeStatus.success &&
                              state.nutritionModel != null
                          ? Builder(
                              builder: (context) {
                                const int eatenCalories =
                                    1260; // Breakfast 540 + Lunch 720
                                final int target =
                                    state.nutritionModel!.calories;
                                final int kcalLeft =
                                    (target - eatenCalories).clamp(0, target);
                                return CalorieTrackerCard(
                                  kcalLeft: kcalLeft,
                                  dailyTarget: target,
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                state.nutritionErrorMessage ??
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
                          context.go(AppRoutes.scanner);
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

                  // Today's Meals
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
                        onPressed: () {},
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
                  const MealCardTile(
                    title: 'Breakfast',
                    subtitle: '540 kcal • Completed',
                    imageUrl:
                        'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200',
                    isCompleted: true,
                  ),
                  const MealCardTile(
                    title: 'Lunch',
                    subtitle: '720 kcal • Completed',
                    imageUrl:
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=200',
                    isCompleted: true,
                  ),
                  const MealCardTile(
                    title: 'Dinner',
                    subtitle: 'Planning... AI suggestion ready',
                    placeholderIcon: Icons.restaurant,
                    isCompleted: false,
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
                      const MacroProgressCard(
                        label: 'Protein',
                        value: '95g',
                        progress: 0.75,
                      ),
                      SizedBox(width: 10.w),
                      MacroProgressCard(
                        label: 'Carbs',
                        value: '210g',
                        progress: 0.60,
                        cardBgColor: AppColors.secondaryContainer.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      const MacroProgressCard(
                        label: 'Fat',
                        value: '45g',
                        progress: 0.40,
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
          ),
        ),
      ),
    );
  }
}
