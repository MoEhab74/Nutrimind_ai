import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo.dart';

part 'history_state.dart';

class HistoryMealsCubit extends Cubit<HistoryMealsState> {
  HistoryMealsCubit({required this._mealRepo}) : super(HistoryMealsInitial());

  final MealRepo _mealRepo;

  List<MealModel> meals = [];

  Future<void> getAllMealsOrderedByMealDate() async {
    emit(HistoryMealsLoading());
    try {
      meals = await _mealRepo.getAllMealsOrderedByMealDate();
      emit(HistoryMealsSuccess(meals: meals));
    } catch (e) {
      emit(HistoryMealsError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteAllMeals() async {
    emit(HistoryMealsLoading());
    try {
      await _mealRepo.deleteAllMeals();
      emit(HistoryMealsSuccess(meals: const []));
    } catch (e) {
      emit(HistoryMealsError(errorMessage: e.toString()));
    }
  }
}
