import 'package:nutrimind_ai/core/utils/app_strings.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';

class OnboardingService {
  // Cachehelper instance
  final CacheHelper _cacheHelper;
  OnboardingService(this._cacheHelper);

  static const String _firstVisitKey = AppStrings.isFirstVisitKey;

  /// Checks if this is the user's first time opening the app.
  Future<bool> isFirstVisit() async {
    final dynamic value = _cacheHelper.getData(key: _firstVisitKey);
    // If a boolean is saved (e.g. false when onboarding is complete), return it.
    // If nothing is saved yet (null), it's their first visit (true).
    if (value is bool) {
      return value;
    }
    return value == null;
  }

  /// Marks the onboarding as completed so it won't show again.
  Future<void> completeOnboarding() async {
    // Save a boolean value to indicate they are no longer a first-time visitor
    await _cacheHelper.saveData(key: _firstVisitKey, value: false);
  }

  // Reset onBoarding visit
  Future<void> resetOnboarding() async {
    // Remove the value from cache to make it appear as a first-time visitor again
    await _cacheHelper.removeData(key: _firstVisitKey);
  }
}
