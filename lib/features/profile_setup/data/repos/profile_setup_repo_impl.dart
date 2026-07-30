import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource local;

  ProfileRepositoryImpl(this.local);

  @override
  Future<void> saveProfile(ProfileSetupModel profile) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final Map<String, dynamic> data = {};
      if (profile.gender != null) data['gender'] = profile.gender!.name;
      if (profile.age != null) data['age'] = profile.age;
      if (profile.height != null) data['height'] = profile.height;
      if (profile.weight != null) data['weight'] = profile.weight;
      if (profile.goal != null) data['goal'] = profile.goal!.name;
      if (profile.targetWeight != null) {
        data['targetWeight'] = profile.targetWeight;
      }
      if (profile.activity != null) {
        data['activityLevel'] = profile.activity!.name;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));
      log(
        'Complete profile setup and save it in the firestore with merge option to not overwritting user Auth data',
      );
    }
    return await local.saveProfile(profile);
  }

  @override
  ProfileSetupModel? getProfile() {
    log('Getting profile using repository');
    return local.getProfile();
  }

  @override
  Future<bool> isProfileCompleted() async {
    final cached = local.getProfile();
    if (cached != null) return true;

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        if (data.containsKey('gender') ||
            data.containsKey('age') ||
            data.containsKey('weight') ||
            data.containsKey('goal')) {
          return true;
        }
      }
    } catch (e) {
      log('Error checking profile in Firestore: $e');
    }
    return false;
  }

  @override
  Future<void> clearProfile() {
    log('Clearing profile using repository');
    return local.clear();
  }
}
