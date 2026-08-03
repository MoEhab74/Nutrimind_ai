import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_repo/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/core/shared/repos/user_repo/user_repo.dart';
import 'package:nutrimind_ai/features/home/data/models/user_model.dart';
import 'package:nutrimind_ai/features/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo, {required this.userRepository}) : super(ProfileInitial());

  final NutritionCalculationRepo _repo;
  final UserRepository userRepository;
  
  void calculateProfile() {
    emit(ProfileLoading());
    final result = _repo.calculateNutrition();
    result.fold(
      (error) => emit(ProfileError(error)),
      (nutrition) => emit(ProfileLoadedSuccessfully(nutrition)),
    );
  }
  Future<void> getUserData() async {
    emit(UserdataLoading());
    final result = await userRepository.getUserData();
    result.fold(
      (failure) => emit(UserdataError(failure)),
      (userData) {
        if (userData != null && userData is Map<String, dynamic>) {
          emit(
            UserdataLoadedSuccessfully(
              UserModel(
                fullName: userData['fullName'] as String?,
                emailAddress: userData['emailAddress'] as String?,
                gender: userData['gender'] as String?,
                age: userData['age']?.toString(),
                weight: userData['weight']?.toString(),
                height: userData['height']?.toString(),
                targetWeight: userData['targetWeight']?.toString(),
                goal: userData['goal'] as String?,
              ),
            ),
          );
        } else {
          emit(UserdataError('No user data found'));
        }
      },
    );
  } 
}