// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BetModel _$BetModelFromJson(Map<String, dynamic> json) {
  return _BetModel.fromJson(json);
}

/// @nodoc
mixin _$BetModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  int get creditsStaked => throw _privateConstructorUsedError;
  BetStatus get status => throw _privateConstructorUsedError;
  int get creditsWon => throw _privateConstructorUsedError;
  double? get odds => throw _privateConstructorUsedError;
  DateTime? get placedAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this BetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BetModelCopyWith<BetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BetModelCopyWith<$Res> {
  factory $BetModelCopyWith(BetModel value, $Res Function(BetModel) then) =
      _$BetModelCopyWithImpl<$Res, BetModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String eventId,
    String teamId,
    int creditsStaked,
    BetStatus status,
    int creditsWon,
    double? odds,
    DateTime? placedAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class _$BetModelCopyWithImpl<$Res, $Val extends BetModel>
    implements $BetModelCopyWith<$Res> {
  _$BetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventId = null,
    Object? teamId = null,
    Object? creditsStaked = null,
    Object? status = null,
    Object? creditsWon = null,
    Object? odds = freezed,
    Object? placedAt = freezed,
    Object? resolvedAt = freezed,
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
            eventId:
                null == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String,
            teamId:
                null == teamId
                    ? _value.teamId
                    : teamId // ignore: cast_nullable_to_non_nullable
                        as String,
            creditsStaked:
                null == creditsStaked
                    ? _value.creditsStaked
                    : creditsStaked // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as BetStatus,
            creditsWon:
                null == creditsWon
                    ? _value.creditsWon
                    : creditsWon // ignore: cast_nullable_to_non_nullable
                        as int,
            odds:
                freezed == odds
                    ? _value.odds
                    : odds // ignore: cast_nullable_to_non_nullable
                        as double?,
            placedAt:
                freezed == placedAt
                    ? _value.placedAt
                    : placedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            resolvedAt:
                freezed == resolvedAt
                    ? _value.resolvedAt
                    : resolvedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BetModelImplCopyWith<$Res>
    implements $BetModelCopyWith<$Res> {
  factory _$$BetModelImplCopyWith(
    _$BetModelImpl value,
    $Res Function(_$BetModelImpl) then,
  ) = __$$BetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String eventId,
    String teamId,
    int creditsStaked,
    BetStatus status,
    int creditsWon,
    double? odds,
    DateTime? placedAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$BetModelImplCopyWithImpl<$Res>
    extends _$BetModelCopyWithImpl<$Res, _$BetModelImpl>
    implements _$$BetModelImplCopyWith<$Res> {
  __$$BetModelImplCopyWithImpl(
    _$BetModelImpl _value,
    $Res Function(_$BetModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventId = null,
    Object? teamId = null,
    Object? creditsStaked = null,
    Object? status = null,
    Object? creditsWon = null,
    Object? odds = freezed,
    Object? placedAt = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$BetModelImpl(
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
        eventId:
            null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String,
        teamId:
            null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                    as String,
        creditsStaked:
            null == creditsStaked
                ? _value.creditsStaked
                : creditsStaked // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as BetStatus,
        creditsWon:
            null == creditsWon
                ? _value.creditsWon
                : creditsWon // ignore: cast_nullable_to_non_nullable
                    as int,
        odds:
            freezed == odds
                ? _value.odds
                : odds // ignore: cast_nullable_to_non_nullable
                    as double?,
        placedAt:
            freezed == placedAt
                ? _value.placedAt
                : placedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        resolvedAt:
            freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BetModelImpl implements _BetModel {
  const _$BetModelImpl({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.teamId,
    required this.creditsStaked,
    this.status = BetStatus.pending,
    this.creditsWon = 0,
    this.odds,
    this.placedAt,
    this.resolvedAt,
  });

  factory _$BetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String eventId;
  @override
  final String teamId;
  @override
  final int creditsStaked;
  @override
  @JsonKey()
  final BetStatus status;
  @override
  @JsonKey()
  final int creditsWon;
  @override
  final double? odds;
  @override
  final DateTime? placedAt;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'BetModel(id: $id, userId: $userId, eventId: $eventId, teamId: $teamId, creditsStaked: $creditsStaked, status: $status, creditsWon: $creditsWon, odds: $odds, placedAt: $placedAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.creditsStaked, creditsStaked) ||
                other.creditsStaked == creditsStaked) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.creditsWon, creditsWon) ||
                other.creditsWon == creditsWon) &&
            (identical(other.odds, odds) || other.odds == odds) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    eventId,
    teamId,
    creditsStaked,
    status,
    creditsWon,
    odds,
    placedAt,
    resolvedAt,
  );

  /// Create a copy of BetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BetModelImplCopyWith<_$BetModelImpl> get copyWith =>
      __$$BetModelImplCopyWithImpl<_$BetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BetModelImplToJson(this);
  }
}

abstract class _BetModel implements BetModel {
  const factory _BetModel({
    required final String id,
    required final String userId,
    required final String eventId,
    required final String teamId,
    required final int creditsStaked,
    final BetStatus status,
    final int creditsWon,
    final double? odds,
    final DateTime? placedAt,
    final DateTime? resolvedAt,
  }) = _$BetModelImpl;

  factory _BetModel.fromJson(Map<String, dynamic> json) =
      _$BetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get eventId;
  @override
  String get teamId;
  @override
  int get creditsStaked;
  @override
  BetStatus get status;
  @override
  int get creditsWon;
  @override
  double? get odds;
  @override
  DateTime? get placedAt;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of BetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BetModelImplCopyWith<_$BetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
