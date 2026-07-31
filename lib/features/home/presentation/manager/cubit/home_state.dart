part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, error }

@immutable
class HomeState {
  final HomeStatus nutritionStatus;
  final HomeStatus userStatus;
  final NutritionModel? nutritionModel;
  final UserModel? userModel;
  final String? nutritionErrorMessage;
  final String? userErrorMessage;

  const HomeState({
    this.nutritionStatus = HomeStatus.initial,
    this.userStatus = HomeStatus.initial,
    this.nutritionModel,
    this.userModel,
    this.nutritionErrorMessage,
    this.userErrorMessage,
  });

  HomeState copyWith({
    HomeStatus? nutritionStatus,
    HomeStatus? userStatus,
    NutritionModel? nutritionModel,
    UserModel? userModel,
    String? nutritionErrorMessage,
    String? userErrorMessage,
  }) {
    return HomeState(
      nutritionStatus: nutritionStatus ?? this.nutritionStatus,
      userStatus: userStatus ?? this.userStatus,
      nutritionModel: nutritionModel ?? this.nutritionModel,
      userModel: userModel ?? this.userModel,
      nutritionErrorMessage:
          nutritionErrorMessage ?? this.nutritionErrorMessage,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
    );
  }
}
