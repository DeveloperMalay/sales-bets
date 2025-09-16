import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _firstTimeUserKey = 'first_time_user';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Onboarding related
  static Future<bool> isOnboardingCompleted() async {
    await init();
    return _prefs?.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    await init();
    await _prefs?.setBool(_onboardingCompletedKey, completed);
  }

  // First time user
  static Future<bool> isFirstTimeUser() async {
    await init();
    return _prefs?.getBool(_firstTimeUserKey) ?? true;
  }

  static Future<void> setFirstTimeUser(bool isFirstTime) async {
    await init();
    await _prefs?.setBool(_firstTimeUserKey, isFirstTime);
  }

  // Clear all preferences (useful for testing or logout)
  static Future<void> clear() async {
    await init();
    await _prefs?.clear();
  }

  // User settings
  static Future<void> setUserSetting(String key, dynamic value) async {
    await init();
    if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs?.setStringList(key, value);
    }
  }

  static Future<T?> getUserSetting<T>(String key, {T? defaultValue}) async {
    await init();
    if (T == String) {
      return _prefs?.getString(key) as T? ?? defaultValue;
    } else if (T == bool) {
      return _prefs?.getBool(key) as T? ?? defaultValue;
    } else if (T == int) {
      return _prefs?.getInt(key) as T? ?? defaultValue;
    } else if (T == double) {
      return _prefs?.getDouble(key) as T? ?? defaultValue;
    } else if (T == List<String>) {
      return _prefs?.getStringList(key) as T? ?? defaultValue;
    }
    return defaultValue;
  }
}