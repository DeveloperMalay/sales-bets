// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      credits: (json['credits'] as num?)?.toInt() ?? 1000,
      followedTeamIds:
          (json['followedTeamIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      betIds:
          (json['betIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalWins: (json['totalWins'] as num?)?.toInt() ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toInt() ?? 0,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      lastLoginAt:
          json['lastLoginAt'] == null
              ? null
              : DateTime.parse(json['lastLoginAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
      'credits': instance.credits,
      'followedTeamIds': instance.followedTeamIds,
      'betIds': instance.betIds,
      'totalWins': instance.totalWins,
      'totalEarnings': instance.totalEarnings,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
    };
