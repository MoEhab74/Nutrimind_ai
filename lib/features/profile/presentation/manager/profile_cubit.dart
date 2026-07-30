import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/features/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());

  final NutritionCalculationRepo _repo;
  
  void calculateProfile() {
    emit(ProfileLoading());
    final result = _repo.calculateNutrition();
    result.fold(
      (error) => emit(ProfileError(error)),
      (nutrition) => emit(ProfileLoadedSuccessfully(nutrition)),
    );
  }

  
}