import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/core/shared/repos/user_repo/user_repo.dart';
import 'package:nutrimind_ai/features/home/data/models/user_model.dart';
import 'package:nutrimind_ai/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository, required this.userRepository})
      : super(const HomeState());

  final HomeRepository homeRepository;
  final UserRepository userRepository;

  Future<void> getNutrition() async {
    emit(state.copyWith(nutritionStatus: HomeStatus.loading));
    final result = await homeRepository.getNutrition();
    result.fold(
      (failure) => emit(
        state.copyWith(
          nutritionStatus: HomeStatus.error,
          nutritionErrorMessage: failure,
        ),
      ),
      (nutritionModel) => emit(
        state.copyWith(
          nutritionStatus: HomeStatus.success,
          nutritionModel: nutritionModel,
        ),
      ),
    );
  }

  Future<void> getUserData() async {
    emit(state.copyWith(userStatus: HomeStatus.loading));
    final result = await userRepository.getUserData();
    result.fold(
      (failure) => emit(
        state.copyWith(
          userStatus: HomeStatus.error,
          userErrorMessage: failure,
        ),
      ),
      (userData) {
        if (userData != null && userData is Map<String, dynamic>) {
          final userModel = UserModel(
            fullName: userData['fullName'] as String?,
            emailAddress: userData['emailAddress'] as String?,
            gender: userData['gender'] as String?,
            age: userData['age']?.toString(),
            weight: userData['weight']?.toString(),
            height: userData['height']?.toString(),
            targetWeight: userData['targetWeight']?.toString(),
            goal: userData['goal'] as String?,
          );
          emit(
            state.copyWith(
              userStatus: HomeStatus.success,
              userModel: userModel,
            ),
          );
        } else {
          emit(
            state.copyWith(
              userStatus: HomeStatus.error,
              userErrorMessage: 'User data not found',
            ),
          );
        }
      },
    );
  }
}
