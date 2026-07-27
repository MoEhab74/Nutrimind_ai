import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/utils/app_strings.dart';

class IsLoggedInService {
  final CacheHelper _cacheHelper;
  IsLoggedInService(this._cacheHelper);

  static const String _isLoggedInKey = AppStrings.isLoggedInKey;

  Future<bool> isLoggedIn() async {
    return _cacheHelper.getData(key: _isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _cacheHelper.saveData(key: _isLoggedInKey, value: value);
  }

  Future<void> clearLoggedIn() async {
    await _cacheHelper.removeData(key: _isLoggedInKey);
  }
}
