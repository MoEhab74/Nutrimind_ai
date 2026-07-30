import 'package:dartz/dartz.dart';
import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';

abstract class NutritionCalculationRepo {
  Either<String, NutritionModel> calculateNutrition();
}
