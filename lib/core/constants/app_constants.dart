class AppConstants {
  // App Info
  static const String appName = 'Sales Bets';
  static const String appTagline = 'Win but never lose!';
  
  // Default Values
  static const int defaultCredits = 1000;
  static const int minBetAmount = 10;
  static const int maxBetAmount = 500;
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration slowAnimation = Duration(milliseconds: 800);
  
  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;
  
  // Border Radius
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double extraLargeRadius = 24.0;
  
  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String themeCacheKey = 'theme_mode';
  static const String onboardingCacheKey = 'onboarding_completed';
  
  // Asset Paths
  static const String lottieWin = 'assets/animations/win.json';
  static const String lottieCelebration = 'assets/animations/celebration.json';
  static const String lottieLoading = 'assets/animations/loading.json';
  
  // Image Placeholders
  static const String defaultTeamLogo = 'https://via.placeholder.com/100x100/6C63FF/FFFFFF?text=TEAM';
  static const String defaultUserAvatar = 'https://via.placeholder.com/100x100/03DAC6/FFFFFF?text=USER';
  static const String defaultEventBanner = 'https://via.placeholder.com/400x200/FF6B6B/FFFFFF?text=EVENT';
}