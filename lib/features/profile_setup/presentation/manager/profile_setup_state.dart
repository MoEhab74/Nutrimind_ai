import '../../data/models/profile_setup_model.dart';

class ProfileSetupState {
  final int currentStep;

  final ProfileSetupModel profile;

  const ProfileSetupState({
    this.currentStep = 0,
    this.profile = const ProfileSetupModel(),
  });

  ProfileSetupState copyWith({
    int? currentStep,
    ProfileSetupModel? profile,
  }) {
    return ProfileSetupState(
      currentStep: currentStep ?? this.currentStep,
      profile: profile ?? this.profile,
    );
  }
}
// Initial
class ProfileSetupInitial extends ProfileSetupState {
  const ProfileSetupInitial({super.currentStep, super.profile});
}

// Loading
class ProfileSetupLoading extends ProfileSetupState {
  const ProfileSetupLoading({super.currentStep, super.profile});
}

