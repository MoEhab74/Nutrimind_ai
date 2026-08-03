import 'package:nutrimind_ai/core/shared/models/meal_model.dart';

abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealAddedSuccessfully extends MealState {
  final MealModel mealModel;

  MealAddedSuccessfully({required this.mealModel});
}

class MealsRetrievedSuccess extends MealState {
  final List<MealModel> meals;

  MealsRetrievedSuccess({required this.meals});
}

class MealFailure extends MealState {
  final String errorMessage;

  MealFailure({required this.errorMessage});
}

class MealDeleteSuccess extends MealState {}

class MealDeleteFailure extends MealState {
  final String errorMessage;

  MealDeleteFailure({required this.errorMessage});
}
