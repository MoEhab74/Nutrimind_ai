import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/dio_consumer.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/cache/secure_cache_helper.dart';
import 'package:nutrimind_ai/core/services/is_logged_in_service.dart';
import 'package:nutrimind_ai/core/services/onboarding_service.dart';
import 'package:nutrimind_ai/core/services/tokens_secure_service.dart';

import 'package:nutrimind_ai/features/profile_setup/presentation/manager/profile_setup_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register App repositories
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerFactory<ProfileSetupCubit>(() => ProfileSetupCubit());
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
}
