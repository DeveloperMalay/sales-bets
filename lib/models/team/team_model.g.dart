// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      logoUrl: json['logoUrl'] as String?,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toInt() ?? 0,
      athleteIds:
          (json['athleteIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isLive: json['isLive'] as bool? ?? false,
      currentStreamUrl: json['currentStreamUrl'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      lastActiveAt:
          json['lastActiveAt'] == null
              ? null
              : DateTime.parse(json['lastActiveAt'] as String),
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'wins': instance.wins,
      'losses': instance.losses,
      'followers': instance.followers,
      'totalEarnings': instance.totalEarnings,
      'athleteIds': instance.athleteIds,
      'achievements': instance.achievements,
      'isLive': instance.isLive,
      'currentStreamUrl': instance.currentStreamUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
    };
