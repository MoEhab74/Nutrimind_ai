import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadedSuccessfully extends ProfileState {
  final NutritionModel nutrition;

  ProfileLoadedSuccessfully(this.nutrition);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}