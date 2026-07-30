import 'package:dartz/dartz.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileSetupModel>> getProfile();
}