import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/theme/themes/app_themes.dart';
import 'package:nutrimind_ai/core/theme/themes/manager/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper,
        super(ThemeInitial());
  final CacheHelper _cacheHelper;

  static const String _themeKey = 'is_dark_theme';
  ThemeMode themeMode = ThemeMode.light;

  ThemeData get currentTheme =>
      themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;

  // loadSavedTheme method to use it when the app starts
  void loadSavedTheme() {
    final isDarkTheme = _cacheHelper.getData(key: _themeKey) as bool?;
    if (isDarkTheme != null) {
      themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    }
    emit(ThemeLoaded(themeMode));
  }

  // toggleTheme method to use it when the user toggles the theme
  void toggleTheme() {
    emit(ThemeChangeLoading());
    try {
      themeMode =
          themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      _cacheHelper.saveData(
        key: _themeKey,
        value: themeMode == ThemeMode.dark,
      );
      emit(ThemeLoaded(themeMode));
    } catch (e) {
      emit(ThemeChangeFailed(e.toString()));
    }
  }
}

