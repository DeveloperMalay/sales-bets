// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      teamIds:
          (json['teamIds'] as List<dynamic>).map((e) => e as String).toList(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime:
          json['endTime'] == null
              ? null
              : DateTime.parse(json['endTime'] as String),
      status:
          $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.upcoming,
      streamUrl: json['streamUrl'] as String?,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      odds:
          (json['odds'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      winnerId: json['winnerId'] as String?,
      totalBetsPlaced: (json['totalBetsPlaced'] as num?)?.toInt() ?? 0,
      totalCreditsWagered: (json['totalCreditsWagered'] as num?)?.toInt() ?? 0,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'teamIds': instance.teamIds,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': _$EventStatusEnumMap[instance.status]!,
      'streamUrl': instance.streamUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'odds': instance.odds,
      'winnerId': instance.winnerId,
      'totalBetsPlaced': instance.totalBetsPlaced,
      'totalCreditsWagered': instance.totalCreditsWagered,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$EventStatusEnumMap = {
  EventStatus.upcoming: 'upcoming',
  EventStatus.live: 'live',
  EventStatus.completed: 'completed',
  EventStatus.cancelled: 'cancelled',
};
