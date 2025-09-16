part of 'theme_cubit.dart';

class ThemeState {
  const ThemeState({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isLightMode => themeMode == ThemeMode.light;
}