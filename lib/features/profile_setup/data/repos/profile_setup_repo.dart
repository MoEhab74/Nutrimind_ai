import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';

abstract interface class ProfileRepository {
  Future<void> saveProfile(ProfileSetupModel profile);

  ProfileSetupModel? getProfile();

  Future<void> clearProfile();
}