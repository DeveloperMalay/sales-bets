// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  int get credits => throw _privateConstructorUsedError;
  List<String> get followedTeamIds => throw _privateConstructorUsedError;
  List<String> get betIds => throw _privateConstructorUsedError;
  int get totalWins => throw _privateConstructorUsedError;
  int get totalLosses => throw _privateConstructorUsedError;
  int get totalEarnings => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String email,
    String displayName,
    String? profileImageUrl,
    int credits,
    List<String> followedTeamIds,
    List<String> betIds,
    int totalWins,
    int totalLosses,
    int totalEarnings,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImageUrl = freezed,
    Object? credits = null,
    Object? followedTeamIds = null,
    Object? betIds = null,
    Object? totalWins = null,
    Object? totalLosses = null,
    Object? totalEarnings = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            displayName:
                null == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String,
            profileImageUrl:
                freezed == profileImageUrl
                    ? _value.profileImageUrl
                    : profileImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            credits:
                null == credits
                    ? _value.credits
                    : credits // ignore: cast_nullable_to_non_nullable
                        as int,
            followedTeamIds:
                null == followedTeamIds
                    ? _value.followedTeamIds
                    : followedTeamIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            betIds:
                null == betIds
                    ? _value.betIds
                    : betIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            totalWins:
                null == totalWins
                    ? _value.totalWins
                    : totalWins // ignore: cast_nullable_to_non_nullable
                        as int,
            totalLosses:
                null == totalLosses
                    ? _value.totalLosses
                    : totalLosses // ignore: cast_nullable_to_non_nullable
                        as int,
            totalEarnings:
                null == totalEarnings
                    ? _value.totalEarnings
                    : totalEarnings // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastLoginAt:
                freezed == lastLoginAt
                    ? _value.lastLoginAt
                    : lastLoginAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String displayName,
    String? profileImageUrl,
    int credits,
    List<String> followedTeamIds,
    List<String> betIds,
    int totalWins,
    int totalLosses,
    int totalEarnings,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImageUrl = freezed,
    Object? credits = null,
    Object? followedTeamIds = null,
    Object? betIds = null,
    Object? totalWins = null,
    Object? totalLosses = null,
    Object? totalEarnings = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        displayName:
            null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String,
        profileImageUrl:
            freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        credits:
            null == credits
                ? _value.credits
                : credits // ignore: cast_nullable_to_non_nullable
                    as int,
        followedTeamIds:
            null == followedTeamIds
                ? _value._followedTeamIds
                : followedTeamIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        betIds:
            null == betIds
                ? _value._betIds
                : betIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        totalWins:
            null == totalWins
                ? _value.totalWins
                : totalWins // ignore: cast_nullable_to_non_nullable
                    as int,
        totalLosses:
            null == totalLosses
                ? _value.totalLosses
                : totalLosses // ignore: cast_nullable_to_non_nullable
                    as int,
        totalEarnings:
            null == totalEarnings
                ? _value.totalEarnings
                : totalEarnings // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastLoginAt:
            freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    required this.displayName,
    this.profileImageUrl,
    this.credits = 1000,
    final List<String> followedTeamIds = const [],
    final List<String> betIds = const [],
    this.totalWins = 0,
    this.totalLosses = 0,
    this.totalEarnings = 0,
    this.createdAt,
    this.lastLoginAt,
  }) : _followedTeamIds = followedTeamIds,
       _betIds = betIds;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String? profileImageUrl;
  @override
  @JsonKey()
  final int credits;
  final List<String> _followedTeamIds;
  @override
  @JsonKey()
  List<String> get followedTeamIds {
    if (_followedTeamIds is EqualUnmodifiableListView) return _followedTeamIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followedTeamIds);
  }

  final List<String> _betIds;
  @override
  @JsonKey()
  List<String> get betIds {
    if (_betIds is EqualUnmodifiableListView) return _betIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_betIds);
  }

  @override
  @JsonKey()
  final int totalWins;
  @override
  @JsonKey()
  final int totalLosses;
  @override
  @JsonKey()
  final int totalEarnings;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, profileImageUrl: $profileImageUrl, credits: $credits, followedTeamIds: $followedTeamIds, betIds: $betIds, totalWins: $totalWins, totalLosses: $totalLosses, totalEarnings: $totalEarnings, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            const DeepCollectionEquality().equals(
              other._followedTeamIds,
              _followedTeamIds,
            ) &&
            const DeepCollectionEquality().equals(other._betIds, _betIds) &&
            (identical(other.totalWins, totalWins) ||
                other.totalWins == totalWins) &&
            (identical(other.totalLosses, totalLosses) ||
                other.totalLosses == totalLosses) &&
            (identical(other.totalEarnings, totalEarnings) ||
                other.totalEarnings == totalEarnings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    displayName,
    profileImageUrl,
    credits,
    const DeepCollectionEquality().hash(_followedTeamIds),
    const DeepCollectionEquality().hash(_betIds),
    totalWins,
    totalLosses,
    totalEarnings,
    createdAt,
    lastLoginAt,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String id,
    required final String email,
    required final String displayName,
    final String? profileImageUrl,
    final int credits,
    final List<String> followedTeamIds,
    final List<String> betIds,
    final int totalWins,
    final int totalLosses,
    final int totalEarnings,
    final DateTime? createdAt,
    final DateTime? lastLoginAt,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get displayName;
  @override
  String? get profileImageUrl;
  @override
  int get credits;
  @override
  List<String> get followedTeamIds;
  @override
  List<String> get betIds;
  @override
  int get totalWins;
  @override
  int get totalLosses;
  @override
  int get totalEarnings;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
