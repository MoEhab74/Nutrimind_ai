import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimind_ai/features/scanner/data/models/food_model.dart';

class MealModel {
  final String mealName;
  final int mealHealthScore;
  final String mealImageUrl;
  final int mealCalories;
  final int mealProtein;
  final int mealCarbs;
  final int mealFat;
  final int mealSugar;
  final int mealFiber;
  final int mealSodium;
  final DateTime mealDate;

  MealModel({
    required this.mealName,
    required this.mealHealthScore,
    required this.mealImageUrl,
    required this.mealCalories,
    required this.mealProtein,
    required this.mealCarbs,
    required this.mealFat,
    required this.mealSugar,
    required this.mealFiber,
    required this.mealSodium,
    required this.mealDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealName': mealName,
      'mealHealthScore': mealHealthScore,
      'mealImageUrl': mealImageUrl,
      'mealCalories': mealCalories,
      'mealProtein': mealProtein,
      'mealCarbs': mealCarbs,
      'mealFat': mealFat,
      'mealSugar': mealSugar,
      'mealFiber': mealFiber,
      'mealSodium': mealSodium,
      'mealDate': mealDate,
    };
  }
  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.round();
    if (value is String) return num.tryParse(value)?.round() ?? 0;
    return 0;
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      mealName: map['mealName'] ?? '',
      mealHealthScore: _toInt(map['mealHealthScore']),
      mealImageUrl: map['mealImageUrl'] ?? '',
      mealCalories: _toInt(map['mealCalories']),
      mealProtein: _toInt(map['mealProtein']),
      mealCarbs: _toInt(map['mealCarbs']),
      mealFat: _toInt(map['mealFat']),
      mealSugar: _toInt(map['mealSugar']),
      mealFiber: _toInt(map['mealFiber']),
      mealSodium: _toInt(map['mealSodium']),
      mealDate: map['mealDate'] is Timestamp
          ? (map['mealDate'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

factory MealModel.fromFood(FoodModel food) {
  return MealModel(
    mealName: food.name ?? '',
    mealHealthScore: food.healthScore ?? 0,
    mealImageUrl: '',
    mealCalories: food.calories ?? 0,
    mealProtein: food.protein ?? 0,
    mealCarbs: food.carbs ?? 0,
    mealFat: food.fat ?? 0,
    mealSugar: food.sugar ?? 0,
    mealFiber: food.fiber ?? 0,
    mealSodium: food.sodium ?? 0,
    mealDate: DateTime.now(),
  );
}
}