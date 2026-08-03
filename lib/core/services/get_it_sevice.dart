import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/dio_consumer.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/services/is_logged_in_service.dart';
import 'package:nutrimind_ai/core/services/nutrition_calculation.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
import 'package:nutrimind_ai/core/services/supabase_storage_service.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_repo/nutrition_calculation_repo.dart';
import 'package:nutrimind_ai/core/shared/repos/nutrition_repo/nutrition_calculation_repo_impl.dart';
import 'package:nutrimind_ai/core/shared/repos/user_repo/user_repo.dart';
import 'package:nutrimind_ai/core/shared/repos/user_repo/user_repo_impl.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/chat/data/repos/chat_repo.dart';
import 'package:nutrimind_ai/features/chat/data/repos/chat_repo_impl.dart';
import 'package:nutrimind_ai/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:nutrimind_ai/features/history/presentation/manager/cubit/history_cubit.dart';
import 'package:nutrimind_ai/features/home/data/repos/home_repo.dart';
import 'package:nutrimind_ai/features/home/data/repos/home_repo_impl.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:nutrimind_ai/features/home/presentation/manager/home_meals_cubit/home_meals_cubit.dart';
import 'package:nutrimind_ai/features/profile/presentation/manager/profile_cubit.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source.dart';
import 'package:nutrimind_ai/features/profile_setup/data/data_source/profile_local_data_source_impl.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo.dart';
import 'package:nutrimind_ai/features/profile_setup/data/repos/profile_setup_repo_impl.dart';

import 'package:nutrimind_ai/features/profile_setup/presentation/manager/profile_setup_cubit.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo.dart';
import 'package:nutrimind_ai/core/shared/repos/meal/meal_repo_impl.dart';
import 'package:nutrimind_ai/features/scanner/data/repos/scan/scan_repo.dart';
import 'package:nutrimind_ai/features/scanner/data/repos/scan/scan_repo_impl.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/meal_cubit/meal_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/scan_cubit/scan_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register App repositories
  getIt.registerFactory<ProfileSetupCubit>(
    () => ProfileSetupCubit(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<IsLoggedInService>(
    () => IsLoggedInService(getIt<CacheHelper>()),
  );

  // Cache Helper
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

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
  getIt.registerFactory<AuthCubit>(() => AuthCubit());
  // register firebase auth instance on the whole app
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // register Nutrition Calculation
  getIt.registerLazySingleton<NutritionCalculator>(() => NutritionCalculator());
  // register NutritionCalculation repo
  getIt.registerLazySingleton<NutritionCalculationRepo>(
    () => NutritionRepoImpl(
      getIt<ProfileRepository>(),
      getIt<NutritionCalculator>(),
    ),
  );
  // register profile cubit
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getIt<NutritionCalculationRepo>(),
      userRepository: getIt<UserRepository>(),
    ),
  );
  // Firebase Firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  // HomeRepo
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepoImpl(getIt<NutritionCalculationRepo>()),
  );
  // HomeCub
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      homeRepository: getIt<HomeRepository>(),
      userRepository: getIt<UserRepository>(),
    ),
  );
  // User repo
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
  );
  // dio, DioConsumer, ApiConsumer
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<ApiConsumer>(() => getIt<DioConsumer>());
  // Chat Repo
  getIt.registerLazySingleton<ChatRepo>(
    () => ChatRepoImpl(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );
  // Chat Cubit
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepo>()));
  // Image picker
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  // Scan Repo & Cubit
  getIt.registerLazySingleton<ScanRepo>(
    () => ScanRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
      imagePicker: getIt<ImagePicker>(),
    ),
  );
  getIt.registerFactory<ScanCubit>(
    () => ScanCubit(scanRepo: getIt<ScanRepo>()),
  );
  // Meal Repos & Cubit & SupabaseStorage
  getIt.registerLazySingleton<SupabaseStorageService>(
    () => SupabaseStorageService(),
  );
  getIt.registerLazySingleton<MealRepo>(
    () => MealRepoImpl(
      supabaseStorageService: getIt<SupabaseStorageService>(),
      firebaseAuth: getIt<FirebaseAuth>(),
      firebaseFirestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerFactory<MealCubit>(
    () => MealCubit(mealRepo: getIt<MealRepo>()),
  );
  // HomeMealsCubit
  getIt.registerLazySingleton<HomeMealsCubit>(
    () => HomeMealsCubit(mealRepo: getIt<MealRepo>()),
  );
  // HistoryMealsCubit
  getIt.registerFactory<HistoryMealsCubit>(
    () => HistoryMealsCubit(mealRepo: getIt<MealRepo>()),
  );
}
