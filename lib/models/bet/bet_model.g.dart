// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BetModelImpl _$$BetModelImplFromJson(Map<String, dynamic> json) =>
    _$BetModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      eventId: json['eventId'] as String,
      teamId: json['teamId'] as String,
      creditsStaked: (json['creditsStaked'] as num).toInt(),
      status:
          $enumDecodeNullable(_$BetStatusEnumMap, json['status']) ??
          BetStatus.pending,
      creditsWon: (json['creditsWon'] as num?)?.toInt() ?? 0,
      odds: (json['odds'] as num?)?.toDouble(),
      placedAt:
          json['placedAt'] == null
              ? null
              : DateTime.parse(json['placedAt'] as String),
      resolvedAt:
          json['resolvedAt'] == null
              ? null
              : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$$BetModelImplToJson(_$BetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'eventId': instance.eventId,
      'teamId': instance.teamId,
      'creditsStaked': instance.creditsStaked,
      'status': _$BetStatusEnumMap[instance.status]!,
      'creditsWon': instance.creditsWon,
      'odds': instance.odds,
      'placedAt': instance.placedAt?.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$BetStatusEnumMap = {
  BetStatus.pending: 'pending',
  BetStatus.won: 'won',
  BetStatus.lost: 'lost',
};
