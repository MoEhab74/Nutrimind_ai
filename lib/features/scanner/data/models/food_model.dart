import 'package:nutrimind_ai/core/shared/models/meal_model.dart';

class FoodModel {
  final String? name;
  final int? healthScore;
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final int? sugar;
  final int? fiber;
  final int? sodium;

  FoodModel({
    this.name,
    this.healthScore,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.sugar,
    this.fiber,
    this.sodium,
  });

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.round();
    if (value is String) return num.tryParse(value)?.round();
    return null;
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name']?.toString(),
      healthScore: _toInt(json['healthScore']),
      calories: _toInt(json['calories']),
      protein: _toInt(json['protein']),
      carbs: _toInt(json['carbs']),
      fat: _toInt(json['fat']),
      sugar: _toInt(json['sugar']),
      fiber: _toInt(json['fiber']),
      sodium: _toInt(json['sodium']),
    );
  }
  // From mealModel to FoodModel
  factory FoodModel.fromMealModel(MealModel mealModel) {
   return FoodModel(
     name: mealModel.mealName,
     healthScore: mealModel.mealHealthScore,
     calories: mealModel.mealCalories,
     protein: mealModel.mealProtein,
     carbs: mealModel.mealCarbs,
     fat: mealModel.mealFat,
     sugar: mealModel.mealSugar,
     fiber: mealModel.mealFiber,
     sodium: mealModel.mealSodium,
   );
  }

}
