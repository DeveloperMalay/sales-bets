import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

enum AchievementType {
  // Betting achievements
  firstBet,
  winStreak,
  bigWinner,
  highRoller,
  
  // Social achievements
  chatParticipant,
  socialButterfly,
  
  // Milestone achievements
  earningsLegend,
  bettingVeteran,
  luckyNumber,
  
  // Special achievements
  perfectPredictor,
  earlyBird,
  nightOwl,
}

enum AchievementRarity {
  common,
  rare,
  epic,
  legendary,
}

@freezed
class AchievementModel with _$AchievementModel {
  const factory AchievementModel({
    required String id,
    required String title,
    required String description,
    required String iconName,
    required AchievementType type,
    required AchievementRarity rarity,
    required int requiredValue,
    required int rewardCredits,
    @Default(false) bool isHidden,
    @Default(false) bool isRepeatable,
    DateTime? createdAt,
  }) = _AchievementModel;

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);
}

@freezed
class UserAchievementModel with _$UserAchievementModel {
  const factory UserAchievementModel({
    required String id,
    required String userId,
    required String achievementId,
    required DateTime unlockedAt,
    @Default(false) bool isViewed,
    @Default(1) int count, // For repeatable achievements
  }) = _UserAchievementModel;

  factory UserAchievementModel.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementModelFromJson(json);
}