import 'package:dartz/dartz.dart';
import 'package:nutrimind_ai/core/services/nutrition_calculation.dart';
import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_repo/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';

class NutritionRepoImpl implements NutritionCalculationRepo {
  final ProfileRepository profileRepository;
  final NutritionCalculator calculator;

  NutritionRepoImpl(this.profileRepository, this.calculator);

  @override
  Either<String, NutritionModel> calculateNutrition() {
    try {
      final profile = profileRepository.getProfile();

      final nutrition = calculator.calculate(
        profile ??
            const ProfileSetupModel(
              gender: Gender.male,
              age: 20,
              weight: 70,
              height: 170,
              activity: ActivityLevel.sedentary,
              goal: Goal.loseWeight,
            ),
      );

      return Right(nutrition);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
