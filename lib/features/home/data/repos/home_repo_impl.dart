import 'package:dartz/dartz.dart';
import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_repo/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepository {
  final NutritionCalculationRepo nutritionCalculationRepo;

  HomeRepoImpl(this.nutritionCalculationRepo);
  @override
  Future<Either<String, NutritionModel>> getNutrition() async {
    return nutritionCalculationRepo.calculateNutrition();
  }
}
