import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/dio_consumer.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/cache/secure_cache_helper.dart';
import 'package:nutrimind_ai/core/services/is_logged_in_service.dart';
import 'package:nutrimind_ai/core/services/nutrition_calculation.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
import 'package:nutrimind_ai/core/services/tokens_secure_service.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_calculation_repo_impl.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/profile/presentation/manager/profile_cubit.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source_impl.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo_impl.dart';

import 'package:nutrimind_ai/features/profile_setup/presentation/manager/profile_setup_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register App repositories
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerFactory<ProfileSetupCubit>(
    () => ProfileSetupCubit(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<IsLoggedInService>(
    () => IsLoggedInService(getIt<CacheHelper>()),
  );
  getIt.registerLazySingleton<TokensSecureService>(
    () => TokensSecureService(getIt<SecureCacheHelper>()),
  );

  // Cache Helper
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Secure Cache Helper
  getIt.registerLazySingleton<SecureCacheHelper>(() => SecureCacheHelper());

  // Onboarding Service
  getIt.registerLazySingleton<OnboardingService>(
    () => OnboardingService(getIt<CacheHelper>()),
  );
  // Profile Setup
  getIt.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(Hive.box<ProfileSetupModel>('profile')),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileLocalDataSource>()),
  );
  // Auth
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(),
  );
  // register firebase auth instance on the whole app
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // register Nutrition Calculation
  getIt.registerLazySingleton<NutritionCalculator>(
    () => NutritionCalculator(),
  );
  // register NutritionCalculation repo
  getIt.registerLazySingleton<NutritionCalculationRepo>(
    () => NutritionRepoImpl(
      getIt<ProfileRepository>(),
      getIt<NutritionCalculator>(),
    ),
  );
  // register profile cubit
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<NutritionCalculationRepo>()),
  );
  // Firebase Firestore
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
