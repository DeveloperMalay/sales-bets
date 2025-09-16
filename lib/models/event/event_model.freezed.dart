// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get teamIds => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  String? get streamUrl => throw _privateConstructorUsedError;
  String? get bannerImageUrl => throw _privateConstructorUsedError;
  Map<String, double> get odds => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  int get totalBetsPlaced => throw _privateConstructorUsedError;
  int get totalCreditsWagered => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
    EventModel value,
    $Res Function(EventModel) then,
  ) = _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    List<String> teamIds,
    DateTime startTime,
    DateTime? endTime,
    EventStatus status,
    String? streamUrl,
    String? bannerImageUrl,
    Map<String, double> odds,
    String? winnerId,
    int totalBetsPlaced,
    int totalCreditsWagered,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? teamIds = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? streamUrl = freezed,
    Object? bannerImageUrl = freezed,
    Object? odds = null,
    Object? winnerId = freezed,
    Object? totalBetsPlaced = null,
    Object? totalCreditsWagered = null,
    Object? createdAt = freezed,
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
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            teamIds:
                null == teamIds
                    ? _value.teamIds
                    : teamIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            endTime:
                freezed == endTime
                    ? _value.endTime
                    : endTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as EventStatus,
            streamUrl:
                freezed == streamUrl
                    ? _value.streamUrl
                    : streamUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            bannerImageUrl:
                freezed == bannerImageUrl
                    ? _value.bannerImageUrl
                    : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            odds:
                null == odds
                    ? _value.odds
                    : odds // ignore: cast_nullable_to_non_nullable
                        as Map<String, double>,
            winnerId:
                freezed == winnerId
                    ? _value.winnerId
                    : winnerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            totalBetsPlaced:
                null == totalBetsPlaced
                    ? _value.totalBetsPlaced
                    : totalBetsPlaced // ignore: cast_nullable_to_non_nullable
                        as int,
            totalCreditsWagered:
                null == totalCreditsWagered
                    ? _value.totalCreditsWagered
                    : totalCreditsWagered // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
    _$EventModelImpl value,
    $Res Function(_$EventModelImpl) then,
  ) = __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    List<String> teamIds,
    DateTime startTime,
    DateTime? endTime,
    EventStatus status,
    String? streamUrl,
    String? bannerImageUrl,
    Map<String, double> odds,
    String? winnerId,
    int totalBetsPlaced,
    int totalCreditsWagered,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
    _$EventModelImpl _value,
    $Res Function(_$EventModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? teamIds = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? streamUrl = freezed,
    Object? bannerImageUrl = freezed,
    Object? odds = null,
    Object? winnerId = freezed,
    Object? totalBetsPlaced = null,
    Object? totalCreditsWagered = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$EventModelImpl(
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
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        teamIds:
            null == teamIds
                ? _value._teamIds
                : teamIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        endTime:
            freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as EventStatus,
        streamUrl:
            freezed == streamUrl
                ? _value.streamUrl
                : streamUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        bannerImageUrl:
            freezed == bannerImageUrl
                ? _value.bannerImageUrl
                : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        odds:
            null == odds
                ? _value._odds
                : odds // ignore: cast_nullable_to_non_nullable
                    as Map<String, double>,
        winnerId:
            freezed == winnerId
                ? _value.winnerId
                : winnerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        totalBetsPlaced:
            null == totalBetsPlaced
                ? _value.totalBetsPlaced
                : totalBetsPlaced // ignore: cast_nullable_to_non_nullable
                    as int,
        totalCreditsWagered:
            null == totalCreditsWagered
                ? _value.totalCreditsWagered
                : totalCreditsWagered // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventModelImpl implements _EventModel {
  const _$EventModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required final List<String> teamIds,
    required this.startTime,
    this.endTime,
    this.status = EventStatus.upcoming,
    this.streamUrl,
    this.bannerImageUrl,
    final Map<String, double> odds = const {},
    this.winnerId,
    this.totalBetsPlaced = 0,
    this.totalCreditsWagered = 0,
    this.createdAt,
  }) : _teamIds = teamIds,
       _odds = odds;

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  final List<String> _teamIds;
  @override
  List<String> get teamIds {
    if (_teamIds is EqualUnmodifiableListView) return _teamIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamIds);
  }

  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  @JsonKey()
  final EventStatus status;
  @override
  final String? streamUrl;
  @override
  final String? bannerImageUrl;
  final Map<String, double> _odds;
  @override
  @JsonKey()
  Map<String, double> get odds {
    if (_odds is EqualUnmodifiableMapView) return _odds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_odds);
  }

  @override
  final String? winnerId;
  @override
  @JsonKey()
  final int totalBetsPlaced;
  @override
  @JsonKey()
  final int totalCreditsWagered;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, teamIds: $teamIds, startTime: $startTime, endTime: $endTime, status: $status, streamUrl: $streamUrl, bannerImageUrl: $bannerImageUrl, odds: $odds, winnerId: $winnerId, totalBetsPlaced: $totalBetsPlaced, totalCreditsWagered: $totalCreditsWagered, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._teamIds, _teamIds) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.bannerImageUrl, bannerImageUrl) ||
                other.bannerImageUrl == bannerImageUrl) &&
            const DeepCollectionEquality().equals(other._odds, _odds) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.totalBetsPlaced, totalBetsPlaced) ||
                other.totalBetsPlaced == totalBetsPlaced) &&
            (identical(other.totalCreditsWagered, totalCreditsWagered) ||
                other.totalCreditsWagered == totalCreditsWagered) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    const DeepCollectionEquality().hash(_teamIds),
    startTime,
    endTime,
    status,
    streamUrl,
    bannerImageUrl,
    const DeepCollectionEquality().hash(_odds),
    winnerId,
    totalBetsPlaced,
    totalCreditsWagered,
    createdAt,
  );

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(this);
  }
}

abstract class _EventModel implements EventModel {
  const factory _EventModel({
    required final String id,
    required final String title,
    required final String description,
    required final List<String> teamIds,
    required final DateTime startTime,
    final DateTime? endTime,
    final EventStatus status,
    final String? streamUrl,
    final String? bannerImageUrl,
    final Map<String, double> odds,
    final String? winnerId,
    final int totalBetsPlaced,
    final int totalCreditsWagered,
    final DateTime? createdAt,
  }) = _$EventModelImpl;

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get teamIds;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  EventStatus get status;
  @override
  String? get streamUrl;
  @override
  String? get bannerImageUrl;
  @override
  Map<String, double> get odds;
  @override
  String? get winnerId;
  @override
  int get totalBetsPlaced;
  @override
  int get totalCreditsWagered;
  @override
  DateTime? get createdAt;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
