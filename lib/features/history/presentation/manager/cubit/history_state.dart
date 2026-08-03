part of 'history_cubit.dart';

@immutable
sealed class HistoryMealsState {}

final class HistoryMealsInitial extends HistoryMealsState {}

final class HistoryMealsLoading extends HistoryMealsState {}

final class HistoryMealsSuccess extends HistoryMealsState {
  final List<MealModel> meals;

  HistoryMealsSuccess({required this.meals});
}

final class HistoryMealsError extends HistoryMealsState {
  final String errorMessage;

  HistoryMealsError({required this.errorMessage});
}

