// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementModelImpl _$$AchievementModelImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  iconName: json['iconName'] as String,
  type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
  rarity: $enumDecode(_$AchievementRarityEnumMap, json['rarity']),
  requiredValue: (json['requiredValue'] as num).toInt(),
  rewardCredits: (json['rewardCredits'] as num).toInt(),
  isHidden: json['isHidden'] as bool? ?? false,
  isRepeatable: json['isRepeatable'] as bool? ?? false,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$AchievementModelImplToJson(
  _$AchievementModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'iconName': instance.iconName,
  'type': _$AchievementTypeEnumMap[instance.type]!,
  'rarity': _$AchievementRarityEnumMap[instance.rarity]!,
  'requiredValue': instance.requiredValue,
  'rewardCredits': instance.rewardCredits,
  'isHidden': instance.isHidden,
  'isRepeatable': instance.isRepeatable,
  'createdAt': instance.createdAt?.toIso8601String(),
};

const _$AchievementTypeEnumMap = {
  AchievementType.firstBet: 'firstBet',
  AchievementType.winStreak: 'winStreak',
  AchievementType.bigWinner: 'bigWinner',
  AchievementType.highRoller: 'highRoller',
  AchievementType.chatParticipant: 'chatParticipant',
  AchievementType.socialButterfly: 'socialButterfly',
  AchievementType.earningsLegend: 'earningsLegend',
  AchievementType.bettingVeteran: 'bettingVeteran',
  AchievementType.luckyNumber: 'luckyNumber',
  AchievementType.perfectPredictor: 'perfectPredictor',
  AchievementType.earlyBird: 'earlyBird',
  AchievementType.nightOwl: 'nightOwl',
};

const _$AchievementRarityEnumMap = {
  AchievementRarity.common: 'common',
  AchievementRarity.rare: 'rare',
  AchievementRarity.epic: 'epic',
  AchievementRarity.legendary: 'legendary',
};

_$UserAchievementModelImpl _$$UserAchievementModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserAchievementModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  achievementId: json['achievementId'] as String,
  unlockedAt: DateTime.parse(json['unlockedAt'] as String),
  isViewed: json['isViewed'] as bool? ?? false,
  count: (json['count'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$UserAchievementModelImplToJson(
  _$UserAchievementModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'achievementId': instance.achievementId,
  'unlockedAt': instance.unlockedAt.toIso8601String(),
  'isViewed': instance.isViewed,
  'count': instance.count,
};
