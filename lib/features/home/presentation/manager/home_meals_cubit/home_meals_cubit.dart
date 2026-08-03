import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_state.dart';


class HomeMealsCubit extends Cubit<HomeMealsState> {
  HomeMealsCubit({required this.mealRepo}) : super(HomeMealsInitial());
  final MealRepo mealRepo;

  List<MealModel> meals = [];

  Future<void> getAllMeals() async {
    emit(HomeMealsLoading());
    try {
      meals = await mealRepo.getAllMeals();
      emit(HomeMealsSuccess(meals: meals));
    } catch (e) {
      emit(HomeMealsError(errorMessage: e.toString()));
    }
  }
}