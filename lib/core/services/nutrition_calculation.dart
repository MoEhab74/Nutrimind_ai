import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';

class NutritionCalculator {
  NutritionModel calculate(ProfileSetupModel profile) {
    double bmr = 0;

    if (profile.gender == Gender.male) {
      bmr =
          (10 * profile.weight!) +
          (6.25 * profile.height!) -
          (5 * profile.age!) +
          5;
    } else {
      bmr =
          (10 * profile.weight!) +
          (6.25 * profile.height!) -
          (5 * profile.age!) -
          161;
    }

    double dailyCalories = 0;

    switch (profile.activity) {
      case ActivityLevel.sedentary:
        dailyCalories = bmr * 1.2;
        break;
      case ActivityLevel.lightlyActive:
        dailyCalories = bmr * 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        dailyCalories = bmr * 1.55;
        break;
      case ActivityLevel.active:
        dailyCalories = bmr * 1.725;
        break;
      case ActivityLevel.veryActive:
        dailyCalories = bmr * 1.9;
        break;
      default:
        dailyCalories = bmr * 1.55;
    }

    if (profile.goal == Goal.loseWeight) {
      dailyCalories -= 500;
    } else if (profile.goal == Goal.gainMuscle) {
      dailyCalories += 500;
    }

    int protein = (1.5 * profile.weight!).round();
    int fat = ((dailyCalories * 0.25) / 9).round();
    int carbs = (dailyCalories - (protein * 4) - (fat * 9)).round();
    int water = (profile.weight! * 35).round();
    int fiber = 30;
    int sugar = (dailyCalories * 0.05 / 4).round();

    return NutritionModel(
      calories: dailyCalories.round(),
      protein: protein,
      carbs: carbs,
      fat: fat,
      water: water,
      fiber: fiber,
      sugar: sugar,
    );
  }
}
