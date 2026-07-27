import 'package:nutrimind_ai/core/api/api_endpoints.dart';
import 'package:nutrimind_ai/core/cache/secure_cache_helper.dart';

class TokensSecureService {
  final SecureCacheHelper _secureCacheHelper;

  TokensSecureService(this._secureCacheHelper);

  static const String _accessTokenKey = ApiKeys.accessToken;
  static const String _refreshTokenKey = ApiKeys.refreshToken;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureCacheHelper.saveData(key: _accessTokenKey, value: accessToken);
    await _secureCacheHelper.saveData(
      key: _refreshTokenKey,
      value: refreshToken,
    );
  }

  Future<String?> getAccessToken() async {
    return await _secureCacheHelper.getData(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureCacheHelper.getData(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _secureCacheHelper.removeData(key: _accessTokenKey);
    await _secureCacheHelper.removeData(key: _refreshTokenKey);
  }
}
