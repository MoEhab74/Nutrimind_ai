import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/profile_setup_model.dart';
import '../../data/repos/profile_setup_repo.dart';
import 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final ProfileRepository _profileRepo;

  ProfileSetupCubit(this._profileRepo) : super(const ProfileSetupState()) {
    _initProfile();
  }

  final PageController pageController = PageController();

  static ProfileSetupCubit of(BuildContext context) => BlocProvider.of(context);

  void _initProfile() {
    final cached = _profileRepo.getProfile();
    if (cached != null) {
      emit(state.copyWith(profile: cached));
    }
  }

  Future<void> saveProfile() async {
    final profileToSave = state.profile;
    emit(ProfileSetupLoading(
      currentStep: state.currentStep,
      profile: profileToSave,
    ));
    await _profileRepo.saveProfile(profileToSave);
    emit(state.copyWith(profile: profileToSave));
  }

  //================ Navigation =================

  void nextStep() {
    if (state.currentStep >= 4) return;

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousStep() {
    if (state.currentStep == 0) return;

    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void goToStep(int step) {
    if (step < 0 || step > 4) return;

    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentStep: step));
  }

  //================ Update Data =================

  void updateGender(Gender gender) {
    emit(state.copyWith(profile: state.profile.copyWith(gender: gender)));
  }

  void updateAge(int age) {
    emit(state.copyWith(profile: state.profile.copyWith(age: age)));
  }

  void updateHeight(double height) {
    emit(state.copyWith(profile: state.profile.copyWith(height: height)));
  }

  void updateWeight(double weight) {
    emit(state.copyWith(profile: state.profile.copyWith(weight: weight)));
  }

  void updateGoal(Goal goal) {
    emit(state.copyWith(profile: state.profile.copyWith(goal: goal)));
  }

  void updateTargetWeight(double weight) {
    emit(state.copyWith(profile: state.profile.copyWith(targetWeight: weight)));
  }

  void updateActivity(ActivityLevel activity) {
    emit(state.copyWith(profile: state.profile.copyWith(activity: activity)));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
