import 'package:nutrimind_ai/core/shared/models/meal_model.dart';

abstract class HomeMealsState {
  const HomeMealsState();
}


class HomeMealsInitial extends HomeMealsState {}
class HomeMealsLoading extends HomeMealsState {}
class HomeMealsSuccess extends HomeMealsState {
  final List<MealModel> meals;
  const HomeMealsSuccess({required this.meals});
}
class HomeMealsError extends HomeMealsState {
  final String errorMessage;
  const HomeMealsError({required this.errorMessage});
}