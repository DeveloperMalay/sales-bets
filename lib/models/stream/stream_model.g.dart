// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreamModelImpl _$$StreamModelImplFromJson(Map<String, dynamic> json) =>
    _$StreamModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      teamId: json['teamId'] as String,
      eventId: json['eventId'] as String?,
      streamUrl: json['streamUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      viewerCount: (json['viewerCount'] as num?)?.toInt() ?? 0,
      isLive: json['isLive'] as bool? ?? false,
      chatMessages:
          (json['chatMessages'] as List<dynamic>?)
              ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      startedAt:
          json['startedAt'] == null
              ? null
              : DateTime.parse(json['startedAt'] as String),
      endedAt:
          json['endedAt'] == null
              ? null
              : DateTime.parse(json['endedAt'] as String),
    );

Map<String, dynamic> _$$StreamModelImplToJson(_$StreamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'teamId': instance.teamId,
      'eventId': instance.eventId,
      'streamUrl': instance.streamUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'viewerCount': instance.viewerCount,
      'isLive': instance.isLive,
      'chatMessages': instance.chatMessages,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      message: json['message'] as String,
      timestamp:
          json['timestamp'] == null
              ? null
              : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'message': instance.message,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
