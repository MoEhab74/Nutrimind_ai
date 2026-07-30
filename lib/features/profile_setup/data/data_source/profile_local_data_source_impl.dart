import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box<ProfileSetupModel> box;

  ProfileLocalDataSourceImpl(this.box);

  @override
  Future<void> saveProfile(ProfileSetupModel profile) {
    log('Saving profile in local data base');
    return box.put('profile', profile);
  }

  @override
  ProfileSetupModel? getProfile() {
    log('Getting profile from local data base');
    return box.get('profile');
  }

  @override
  Future<void> clear() {
    log('profile is clear');
    return box.clear();
  }
}