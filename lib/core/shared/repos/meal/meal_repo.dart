import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/shared/models/meal_model.dart';

abstract class MealRepo {
  // add meal
  Future<void> addMeal(MealModel meal, XFile mealImage);
  // get meals
  Future<List<MealModel>> getAllMeals();

  // get meals ordered by mealDate ascending
  Future<List<MealModel>> getAllMealsOrderedByMealDate();

  // delete all today's meals
  Future<void> deleteAllTodayMeals();

  // delete all meals
  Future<void> deleteAllMeals();
}
