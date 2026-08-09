import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/widgets/top_app_bar.dart';
import 'package:nutrimind_ai/features/history/presentation/manager/cubit/history_cubit.dart';
import 'package:nutrimind_ai/features/history/presentation/widgets/empty_state_widget.dart';
import 'package:nutrimind_ai/features/history/presentation/widgets/meal_card_widget.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/choose_bottom_sheet_widget.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryMealsCubit>().getAllMealsOrderedByMealDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(title: 'History'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: BlocBuilder<HistoryMealsCubit, HistoryMealsState>(
            builder: (context, state) {
              if (state is HistoryMealsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HistoryMealsError) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is HistoryMealsSuccess) {
                // If list is empty first show empty state widget
                if (state.meals.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No meals found',
                    message: 'You have not added any meals yet',
                    buttonText: 'Scan Meal',
                    onButtonPressed: () {
                      // Show Scan Bottom Sheet Widget
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ChooseBottomSheetWidget(),
                      );
                    },
                  );
                }
                return ListView.builder(
                  itemCount: state.meals.length,
                  itemBuilder: (context, index) {
                    return MealCardWidget(
                      mealModel: state.meals[index],
                      onTap: () {
                        // Convert MealModel to FoodModel
                        final foodModel = FoodModel.fromMealModel(
                          state.meals[index],
                        );
                        // Get the XFile image
                        final image = XFile(state.meals[index].mealImageUrl);
                        // Navigate to ScanResultView via go_router
                        context.push(
                          AppRoutes.scanResult,
                          extra: {'foodModel': foodModel, 'image': image},
                        );
                      },
                    );
                  },
                );
              } else {
                return EmptyStateWidget(
                  title: 'No meals found',
                  message: 'You have not added any meals yet',
                  buttonText: 'Scan Meal',
                  onButtonPressed: () {
                    // Show Scan Bottom Sheet Widget
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const ChooseBottomSheetWidget(),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

