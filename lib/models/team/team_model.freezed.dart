// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get bannerImageUrl => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get totalEarnings => throw _privateConstructorUsedError;
  List<String> get athleteIds => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  String? get currentStreamUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;

  /// Serializes this TeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String? logoUrl,
    String? bannerImageUrl,
    int wins,
    int losses,
    int followers,
    int totalEarnings,
    List<String> athleteIds,
    List<String> achievements,
    bool isLive,
    String? currentStreamUrl,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  });
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? logoUrl = freezed,
    Object? bannerImageUrl = freezed,
    Object? wins = null,
    Object? losses = null,
    Object? followers = null,
    Object? totalEarnings = null,
    Object? athleteIds = null,
    Object? achievements = null,
    Object? isLive = null,
    Object? currentStreamUrl = freezed,
    Object? createdAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            logoUrl:
                freezed == logoUrl
                    ? _value.logoUrl
                    : logoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            bannerImageUrl:
                freezed == bannerImageUrl
                    ? _value.bannerImageUrl
                    : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            wins:
                null == wins
                    ? _value.wins
                    : wins // ignore: cast_nullable_to_non_nullable
                        as int,
            losses:
                null == losses
                    ? _value.losses
                    : losses // ignore: cast_nullable_to_non_nullable
                        as int,
            followers:
                null == followers
                    ? _value.followers
                    : followers // ignore: cast_nullable_to_non_nullable
                        as int,
            totalEarnings:
                null == totalEarnings
                    ? _value.totalEarnings
                    : totalEarnings // ignore: cast_nullable_to_non_nullable
                        as int,
            athleteIds:
                null == athleteIds
                    ? _value.athleteIds
                    : athleteIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            achievements:
                null == achievements
                    ? _value.achievements
                    : achievements // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isLive:
                null == isLive
                    ? _value.isLive
                    : isLive // ignore: cast_nullable_to_non_nullable
                        as bool,
            currentStreamUrl:
                freezed == currentStreamUrl
                    ? _value.currentStreamUrl
                    : currentStreamUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastActiveAt:
                freezed == lastActiveAt
                    ? _value.lastActiveAt
                    : lastActiveAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
    _$TeamModelImpl value,
    $Res Function(_$TeamModelImpl) then,
  ) = __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String? logoUrl,
    String? bannerImageUrl,
    int wins,
    int losses,
    int followers,
    int totalEarnings,
    List<String> athleteIds,
    List<String> achievements,
    bool isLive,
    String? currentStreamUrl,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  });
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
    _$TeamModelImpl _value,
    $Res Function(_$TeamModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? logoUrl = freezed,
    Object? bannerImageUrl = freezed,
    Object? wins = null,
    Object? losses = null,
    Object? followers = null,
    Object? totalEarnings = null,
    Object? athleteIds = null,
    Object? achievements = null,
    Object? isLive = null,
    Object? currentStreamUrl = freezed,
    Object? createdAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _$TeamModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        logoUrl:
            freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        bannerImageUrl:
            freezed == bannerImageUrl
                ? _value.bannerImageUrl
                : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        wins:
            null == wins
                ? _value.wins
                : wins // ignore: cast_nullable_to_non_nullable
                    as int,
        losses:
            null == losses
                ? _value.losses
                : losses // ignore: cast_nullable_to_non_nullable
                    as int,
        followers:
            null == followers
                ? _value.followers
                : followers // ignore: cast_nullable_to_non_nullable
                    as int,
        totalEarnings:
            null == totalEarnings
                ? _value.totalEarnings
                : totalEarnings // ignore: cast_nullable_to_non_nullable
                    as int,
        athleteIds:
            null == athleteIds
                ? _value._athleteIds
                : athleteIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        achievements:
            null == achievements
                ? _value._achievements
                : achievements // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isLive:
            null == isLive
                ? _value.isLive
                : isLive // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentStreamUrl:
            freezed == currentStreamUrl
                ? _value.currentStreamUrl
                : currentStreamUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastActiveAt:
            freezed == lastActiveAt
                ? _value.lastActiveAt
                : lastActiveAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl({
    required this.id,
    required this.name,
    required this.description,
    this.logoUrl,
    this.bannerImageUrl,
    this.wins = 0,
    this.losses = 0,
    this.followers = 0,
    this.totalEarnings = 0,
    final List<String> athleteIds = const [],
    final List<String> achievements = const [],
    this.isLive = false,
    this.currentStreamUrl,
    this.createdAt,
    this.lastActiveAt,
  }) : _athleteIds = athleteIds,
       _achievements = achievements;

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? logoUrl;
  @override
  final String? bannerImageUrl;
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final int followers;
  @override
  @JsonKey()
  final int totalEarnings;
  final List<String> _athleteIds;
  @override
  @JsonKey()
  List<String> get athleteIds {
    if (_athleteIds is EqualUnmodifiableListView) return _athleteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_athleteIds);
  }

  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  @JsonKey()
  final bool isLive;
  @override
  final String? currentStreamUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastActiveAt;

  @override
  String toString() {
    return 'TeamModel(id: $id, name: $name, description: $description, logoUrl: $logoUrl, bannerImageUrl: $bannerImageUrl, wins: $wins, losses: $losses, followers: $followers, totalEarnings: $totalEarnings, athleteIds: $athleteIds, achievements: $achievements, isLive: $isLive, currentStreamUrl: $currentStreamUrl, createdAt: $createdAt, lastActiveAt: $lastActiveAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.bannerImageUrl, bannerImageUrl) ||
                other.bannerImageUrl == bannerImageUrl) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.totalEarnings, totalEarnings) ||
                other.totalEarnings == totalEarnings) &&
            const DeepCollectionEquality().equals(
              other._athleteIds,
              _athleteIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._achievements,
              _achievements,
            ) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.currentStreamUrl, currentStreamUrl) ||
                other.currentStreamUrl == currentStreamUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    logoUrl,
    bannerImageUrl,
    wins,
    losses,
    followers,
    totalEarnings,
    const DeepCollectionEquality().hash(_athleteIds),
    const DeepCollectionEquality().hash(_achievements),
    isLive,
    currentStreamUrl,
    createdAt,
    lastActiveAt,
  );

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      __$$TeamModelImplCopyWithImpl<_$TeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamModelImplToJson(this);
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel({
    required final String id,
    required final String name,
    required final String description,
    final String? logoUrl,
    final String? bannerImageUrl,
    final int wins,
    final int losses,
    final int followers,
    final int totalEarnings,
    final List<String> athleteIds,
    final List<String> achievements,
    final bool isLive,
    final String? currentStreamUrl,
    final DateTime? createdAt,
    final DateTime? lastActiveAt,
  }) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get logoUrl;
  @override
  String? get bannerImageUrl;
  @override
  int get wins;
  @override
  int get losses;
  @override
  int get followers;
  @override
  int get totalEarnings;
  @override
  List<String> get athleteIds;
  @override
  List<String> get achievements;
  @override
  bool get isLive;
  @override
  String? get currentStreamUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastActiveAt;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
