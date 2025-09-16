import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadThemeMode();
  }

  void toggleTheme() {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    
    emit(state.copyWith(themeMode: newThemeMode));
    _saveThemeMode(newThemeMode);
  }

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
    _saveThemeMode(themeMode);
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(AppConstants.themeCacheKey) ?? 0;
    final themeMode = ThemeMode.values[themeModeIndex];
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.themeCacheKey, themeMode.index);
  }
}