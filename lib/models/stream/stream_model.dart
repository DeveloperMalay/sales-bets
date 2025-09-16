import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_model.freezed.dart';
part 'stream_model.g.dart';

@freezed
class StreamModel with _$StreamModel {
  const factory StreamModel({
    required String id,
    required String title,
    required String teamId,
    String? eventId,
    required String streamUrl,
    String? thumbnailUrl,
    @Default(0) int viewerCount,
    @Default(false) bool isLive,
    @Default([]) List<ChatMessage> chatMessages,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _StreamModel;

  factory StreamModel.fromJson(Map<String, dynamic> json) =>
      _$StreamModelFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String userId,
    required String username,
    required String message,
    DateTime? timestamp,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}