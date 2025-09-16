// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StreamModel _$StreamModelFromJson(Map<String, dynamic> json) {
  return _StreamModel.fromJson(json);
}

/// @nodoc
mixin _$StreamModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String get streamUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  int get viewerCount => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  List<ChatMessage> get chatMessages => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;

  /// Serializes this StreamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamModelCopyWith<StreamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamModelCopyWith<$Res> {
  factory $StreamModelCopyWith(
    StreamModel value,
    $Res Function(StreamModel) then,
  ) = _$StreamModelCopyWithImpl<$Res, StreamModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String teamId,
    String? eventId,
    String streamUrl,
    String? thumbnailUrl,
    int viewerCount,
    bool isLive,
    List<ChatMessage> chatMessages,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class _$StreamModelCopyWithImpl<$Res, $Val extends StreamModel>
    implements $StreamModelCopyWith<$Res> {
  _$StreamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? teamId = null,
    Object? eventId = freezed,
    Object? streamUrl = null,
    Object? thumbnailUrl = freezed,
    Object? viewerCount = null,
    Object? isLive = null,
    Object? chatMessages = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            teamId:
                null == teamId
                    ? _value.teamId
                    : teamId // ignore: cast_nullable_to_non_nullable
                        as String,
            eventId:
                freezed == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String?,
            streamUrl:
                null == streamUrl
                    ? _value.streamUrl
                    : streamUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            thumbnailUrl:
                freezed == thumbnailUrl
                    ? _value.thumbnailUrl
                    : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            viewerCount:
                null == viewerCount
                    ? _value.viewerCount
                    : viewerCount // ignore: cast_nullable_to_non_nullable
                        as int,
            isLive:
                null == isLive
                    ? _value.isLive
                    : isLive // ignore: cast_nullable_to_non_nullable
                        as bool,
            chatMessages:
                null == chatMessages
                    ? _value.chatMessages
                    : chatMessages // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessage>,
            startedAt:
                freezed == startedAt
                    ? _value.startedAt
                    : startedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            endedAt:
                freezed == endedAt
                    ? _value.endedAt
                    : endedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StreamModelImplCopyWith<$Res>
    implements $StreamModelCopyWith<$Res> {
  factory _$$StreamModelImplCopyWith(
    _$StreamModelImpl value,
    $Res Function(_$StreamModelImpl) then,
  ) = __$$StreamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String teamId,
    String? eventId,
    String streamUrl,
    String? thumbnailUrl,
    int viewerCount,
    bool isLive,
    List<ChatMessage> chatMessages,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class __$$StreamModelImplCopyWithImpl<$Res>
    extends _$StreamModelCopyWithImpl<$Res, _$StreamModelImpl>
    implements _$$StreamModelImplCopyWith<$Res> {
  __$$StreamModelImplCopyWithImpl(
    _$StreamModelImpl _value,
    $Res Function(_$StreamModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? teamId = null,
    Object? eventId = freezed,
    Object? streamUrl = null,
    Object? thumbnailUrl = freezed,
    Object? viewerCount = null,
    Object? isLive = null,
    Object? chatMessages = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _$StreamModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        teamId:
            null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                    as String,
        eventId:
            freezed == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String?,
        streamUrl:
            null == streamUrl
                ? _value.streamUrl
                : streamUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        thumbnailUrl:
            freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        viewerCount:
            null == viewerCount
                ? _value.viewerCount
                : viewerCount // ignore: cast_nullable_to_non_nullable
                    as int,
        isLive:
            null == isLive
                ? _value.isLive
                : isLive // ignore: cast_nullable_to_non_nullable
                    as bool,
        chatMessages:
            null == chatMessages
                ? _value._chatMessages
                : chatMessages // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessage>,
        startedAt:
            freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        endedAt:
            freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamModelImpl implements _StreamModel {
  const _$StreamModelImpl({
    required this.id,
    required this.title,
    required this.teamId,
    this.eventId,
    required this.streamUrl,
    this.thumbnailUrl,
    this.viewerCount = 0,
    this.isLive = false,
    final List<ChatMessage> chatMessages = const [],
    this.startedAt,
    this.endedAt,
  }) : _chatMessages = chatMessages;

  factory _$StreamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String teamId;
  @override
  final String? eventId;
  @override
  final String streamUrl;
  @override
  final String? thumbnailUrl;
  @override
  @JsonKey()
  final int viewerCount;
  @override
  @JsonKey()
  final bool isLive;
  final List<ChatMessage> _chatMessages;
  @override
  @JsonKey()
  List<ChatMessage> get chatMessages {
    if (_chatMessages is EqualUnmodifiableListView) return _chatMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatMessages);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;

  @override
  String toString() {
    return 'StreamModel(id: $id, title: $title, teamId: $teamId, eventId: $eventId, streamUrl: $streamUrl, thumbnailUrl: $thumbnailUrl, viewerCount: $viewerCount, isLive: $isLive, chatMessages: $chatMessages, startedAt: $startedAt, endedAt: $endedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            const DeepCollectionEquality().equals(
              other._chatMessages,
              _chatMessages,
            ) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    teamId,
    eventId,
    streamUrl,
    thumbnailUrl,
    viewerCount,
    isLive,
    const DeepCollectionEquality().hash(_chatMessages),
    startedAt,
    endedAt,
  );

  /// Create a copy of StreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamModelImplCopyWith<_$StreamModelImpl> get copyWith =>
      __$$StreamModelImplCopyWithImpl<_$StreamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamModelImplToJson(this);
  }
}

abstract class _StreamModel implements StreamModel {
  const factory _StreamModel({
    required final String id,
    required final String title,
    required final String teamId,
    final String? eventId,
    required final String streamUrl,
    final String? thumbnailUrl,
    final int viewerCount,
    final bool isLive,
    final List<ChatMessage> chatMessages,
    final DateTime? startedAt,
    final DateTime? endedAt,
  }) = _$StreamModelImpl;

  factory _StreamModel.fromJson(Map<String, dynamic> json) =
      _$StreamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get teamId;
  @override
  String? get eventId;
  @override
  String get streamUrl;
  @override
  String? get thumbnailUrl;
  @override
  int get viewerCount;
  @override
  bool get isLive;
  @override
  List<ChatMessage> get chatMessages;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;

  /// Create a copy of StreamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamModelImplCopyWith<_$StreamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String id,
    String userId,
    String username,
    String message,
    DateTime? timestamp,
  });
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = null,
    Object? message = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            username:
                null == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                freezed == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String username,
    String message,
    DateTime? timestamp,
  });
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = null,
    Object? message = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        username:
            null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.userId,
    required this.username,
    required this.message,
    this.timestamp,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String message;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ChatMessage(id: $id, userId: $userId, username: $username, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, username, message, timestamp);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String userId,
    required final String username,
    required final String message,
    final DateTime? timestamp,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get username;
  @override
  String get message;
  @override
  DateTime? get timestamp;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
