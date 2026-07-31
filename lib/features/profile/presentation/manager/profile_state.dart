import 'package:nutrimind_ai/core/shared/models/nutrition_model.dart';
import 'package:nutrimind_ai/features/home/data/models/user_model.dart';

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

final class UserdataInitial extends ProfileState {}

final class UserdataLoading extends ProfileState {}

final class UserdataLoadedSuccessfully extends ProfileState {
  final UserModel userModel;

  UserdataLoadedSuccessfully(this.userModel);
}

final class UserdataError extends ProfileState {
  final String errorMessage;

  UserdataError(this.errorMessage);
}