import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/dio_consumer.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/cache/secure_cache_helper.dart';
import 'package:nutrimind_ai/core/services/is_logged_in_service.dart';
import 'package:nutrimind_ai/core/services/tokens_secure_service.dart';

final getit = GetIt.instance;

void setupGetIt() {
  // Register App repositories
  getit.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));
  // getit.registerLazySingleton<RegisterRepo>(
  //   () => RegisterRepoImplementation(apiConsumer: getit<ApiConsumer>()),
  // );
  // getit.registerLazySingleton<LoginRepo>(
  //   () => LoginRepoImplementation(
  //     apiConsumer: getit<ApiConsumer>(),
  //     tokenSecureService: getit<TokensSecureService>(),
  //     isLoggedInService: getit<IsLoggedInService>(),
  //   ),
  // );
  // getit.registerLazySingleton<HomeRepo>(
  //   () => HomeRepoImpl(apiConsumer: getit<ApiConsumer>()),
  // );
  // getit.registerLazySingleton<ProfileRepo>(
  //   () => ProfileRepoImpl(apiConsumer: getit<ApiConsumer>()),
  // );
  // // Register cache helpers
  // getit.registerLazySingleton<CacheHelper>(() => CacheHelper());
  // getit.registerLazySingleton<SecureCacheHelper>(() => SecureCacheHelper());
  // getit.registerLazySingleton<OnboardingService>(
  //   () => OnboardingService(getit<CacheHelper>()),
  // );
  getit.registerLazySingleton<IsLoggedInService>(
    () => IsLoggedInService(getit<CacheHelper>()),
  );
  getit.registerLazySingleton<TokensSecureService>(
    () => TokensSecureService(getit<SecureCacheHelper>()),
  );
}
