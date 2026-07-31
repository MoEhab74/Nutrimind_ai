import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';

class NutritionCalculator {
  NutritionModel calculate(ProfileSetupModel profile) {
    // 1. Extract and sanitize inputs with safe defaults
    final double weight = profile.weight ?? 70.0; // kg
    
    // Convert height if provided in meters (e.g. 1.7 -> 170 cm)
    double rawHeight = profile.height ?? 170.0;
    final double heightInCm = rawHeight < 3.0 ? rawHeight * 100 : rawHeight;
    
    final int age = profile.age ?? 25;
    final Gender gender = profile.gender ?? Gender.male;

    // 2. Calculate BMR (Mifflin-St Jeor Equation)
    double bmr = (10 * weight) + (6.25 * heightInCm) - (5 * age);
    if (gender == Gender.male) {
      bmr += 5;
    } else {
      bmr -= 161;
    }

    // 3. Calculate TDEE (Total Daily Energy Expenditure) based on Activity Level
    double tdee = bmr;
    switch (profile.activity) {
      case ActivityLevel.sedentary:
        tdee = bmr * 1.2;
        break;
      case ActivityLevel.lightlyActive:
        tdee = bmr * 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        tdee = bmr * 1.55;
        break;
      case ActivityLevel.active:
        tdee = bmr * 1.725;
        break;
      case ActivityLevel.veryActive:
        tdee = bmr * 1.9;
        break;
      default:
        tdee = bmr * 1.55; // Default to moderately active
    }

    // 4. Adjust calories according to Goal
    double dailyCalories = tdee;
    if (profile.goal == Goal.loseWeight) {
      // 15-20% caloric deficit for sustainable weight loss
      dailyCalories = tdee * 0.80;
    } else if (profile.goal == Goal.gainMuscle) {
      // 10-15% caloric surplus for lean muscle building
      dailyCalories = tdee * 1.12;
    } else if (profile.goal == Goal.maintainWeight) {
      dailyCalories = tdee;
    }

    // Enforce Minimum Safe Calorie Floor
    final double minSafeCalories = (gender == Gender.female) ? 1200.0 : 1500.0;
    if (dailyCalories < minSafeCalories) {
      dailyCalories = minSafeCalories;
    }

    // 5. Calculate Macros (in grams)
    // Protein: 1.8g per kg body weight
    int proteinGrams = (1.8 * weight).round();

    // Fat: 25% of total calories (1g fat = 9 kcal)
    int fatGrams = ((dailyCalories * 0.25) / 9).round();

    // Carbs: Remaining calories (1g carb = 4 kcal)
    double remainingCalories = dailyCalories - (proteinGrams * 4) - (fatGrams * 9);
    int carbsGrams = (remainingCalories / 4).clamp(0.0, double.infinity).round();

    // 6. Water, Fiber, and Sugar targets
    int waterMl = (weight * 35).round(); // 35ml per kg
    int fiberGrams = (gender == Gender.male) ? 38 : 25;
    int sugarGrams = ((dailyCalories * 0.05) / 4).round(); // Max 5% of daily calories from added sugar

    return NutritionModel(
      calories: dailyCalories.round(),
      protein: proteinGrams,
      carbs: carbsGrams,
      fat: fatGrams,
      water: waterMl,
      fiber: fiberGrams,
      sugar: sugarGrams,
    );
  }
}