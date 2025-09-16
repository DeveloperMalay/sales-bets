// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) {
  return _AchievementModel.fromJson(json);
}

/// @nodoc
mixin _$AchievementModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get iconName => throw _privateConstructorUsedError;
  AchievementType get type => throw _privateConstructorUsedError;
  AchievementRarity get rarity => throw _privateConstructorUsedError;
  int get requiredValue => throw _privateConstructorUsedError;
  int get rewardCredits => throw _privateConstructorUsedError;
  bool get isHidden => throw _privateConstructorUsedError;
  bool get isRepeatable => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AchievementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementModelCopyWith<AchievementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementModelCopyWith<$Res> {
  factory $AchievementModelCopyWith(
    AchievementModel value,
    $Res Function(AchievementModel) then,
  ) = _$AchievementModelCopyWithImpl<$Res, AchievementModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String iconName,
    AchievementType type,
    AchievementRarity rarity,
    int requiredValue,
    int rewardCredits,
    bool isHidden,
    bool isRepeatable,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$AchievementModelCopyWithImpl<$Res, $Val extends AchievementModel>
    implements $AchievementModelCopyWith<$Res> {
  _$AchievementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconName = null,
    Object? type = null,
    Object? rarity = null,
    Object? requiredValue = null,
    Object? rewardCredits = null,
    Object? isHidden = null,
    Object? isRepeatable = null,
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
            iconName:
                null == iconName
                    ? _value.iconName
                    : iconName // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as AchievementType,
            rarity:
                null == rarity
                    ? _value.rarity
                    : rarity // ignore: cast_nullable_to_non_nullable
                        as AchievementRarity,
            requiredValue:
                null == requiredValue
                    ? _value.requiredValue
                    : requiredValue // ignore: cast_nullable_to_non_nullable
                        as int,
            rewardCredits:
                null == rewardCredits
                    ? _value.rewardCredits
                    : rewardCredits // ignore: cast_nullable_to_non_nullable
                        as int,
            isHidden:
                null == isHidden
                    ? _value.isHidden
                    : isHidden // ignore: cast_nullable_to_non_nullable
                        as bool,
            isRepeatable:
                null == isRepeatable
                    ? _value.isRepeatable
                    : isRepeatable // ignore: cast_nullable_to_non_nullable
                        as bool,
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
abstract class _$$AchievementModelImplCopyWith<$Res>
    implements $AchievementModelCopyWith<$Res> {
  factory _$$AchievementModelImplCopyWith(
    _$AchievementModelImpl value,
    $Res Function(_$AchievementModelImpl) then,
  ) = __$$AchievementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String iconName,
    AchievementType type,
    AchievementRarity rarity,
    int requiredValue,
    int rewardCredits,
    bool isHidden,
    bool isRepeatable,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$AchievementModelImplCopyWithImpl<$Res>
    extends _$AchievementModelCopyWithImpl<$Res, _$AchievementModelImpl>
    implements _$$AchievementModelImplCopyWith<$Res> {
  __$$AchievementModelImplCopyWithImpl(
    _$AchievementModelImpl _value,
    $Res Function(_$AchievementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconName = null,
    Object? type = null,
    Object? rarity = null,
    Object? requiredValue = null,
    Object? rewardCredits = null,
    Object? isHidden = null,
    Object? isRepeatable = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$AchievementModelImpl(
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
        iconName:
            null == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as AchievementType,
        rarity:
            null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                    as AchievementRarity,
        requiredValue:
            null == requiredValue
                ? _value.requiredValue
                : requiredValue // ignore: cast_nullable_to_non_nullable
                    as int,
        rewardCredits:
            null == rewardCredits
                ? _value.rewardCredits
                : rewardCredits // ignore: cast_nullable_to_non_nullable
                    as int,
        isHidden:
            null == isHidden
                ? _value.isHidden
                : isHidden // ignore: cast_nullable_to_non_nullable
                    as bool,
        isRepeatable:
            null == isRepeatable
                ? _value.isRepeatable
                : isRepeatable // ignore: cast_nullable_to_non_nullable
                    as bool,
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
class _$AchievementModelImpl implements _AchievementModel {
  const _$AchievementModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.type,
    required this.rarity,
    required this.requiredValue,
    required this.rewardCredits,
    this.isHidden = false,
    this.isRepeatable = false,
    this.createdAt,
  });

  factory _$AchievementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String iconName;
  @override
  final AchievementType type;
  @override
  final AchievementRarity rarity;
  @override
  final int requiredValue;
  @override
  final int rewardCredits;
  @override
  @JsonKey()
  final bool isHidden;
  @override
  @JsonKey()
  final bool isRepeatable;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AchievementModel(id: $id, title: $title, description: $description, iconName: $iconName, type: $type, rarity: $rarity, requiredValue: $requiredValue, rewardCredits: $rewardCredits, isHidden: $isHidden, isRepeatable: $isRepeatable, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.requiredValue, requiredValue) ||
                other.requiredValue == requiredValue) &&
            (identical(other.rewardCredits, rewardCredits) ||
                other.rewardCredits == rewardCredits) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.isRepeatable, isRepeatable) ||
                other.isRepeatable == isRepeatable) &&
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
    iconName,
    type,
    rarity,
    requiredValue,
    rewardCredits,
    isHidden,
    isRepeatable,
    createdAt,
  );

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementModelImplCopyWith<_$AchievementModelImpl> get copyWith =>
      __$$AchievementModelImplCopyWithImpl<_$AchievementModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementModelImplToJson(this);
  }
}

abstract class _AchievementModel implements AchievementModel {
  const factory _AchievementModel({
    required final String id,
    required final String title,
    required final String description,
    required final String iconName,
    required final AchievementType type,
    required final AchievementRarity rarity,
    required final int requiredValue,
    required final int rewardCredits,
    final bool isHidden,
    final bool isRepeatable,
    final DateTime? createdAt,
  }) = _$AchievementModelImpl;

  factory _AchievementModel.fromJson(Map<String, dynamic> json) =
      _$AchievementModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get iconName;
  @override
  AchievementType get type;
  @override
  AchievementRarity get rarity;
  @override
  int get requiredValue;
  @override
  int get rewardCredits;
  @override
  bool get isHidden;
  @override
  bool get isRepeatable;
  @override
  DateTime? get createdAt;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementModelImplCopyWith<_$AchievementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAchievementModel _$UserAchievementModelFromJson(Map<String, dynamic> json) {
  return _UserAchievementModel.fromJson(json);
}

/// @nodoc
mixin _$UserAchievementModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get achievementId => throw _privateConstructorUsedError;
  DateTime get unlockedAt => throw _privateConstructorUsedError;
  bool get isViewed => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this UserAchievementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAchievementModelCopyWith<UserAchievementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAchievementModelCopyWith<$Res> {
  factory $UserAchievementModelCopyWith(
    UserAchievementModel value,
    $Res Function(UserAchievementModel) then,
  ) = _$UserAchievementModelCopyWithImpl<$Res, UserAchievementModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String achievementId,
    DateTime unlockedAt,
    bool isViewed,
    int count,
  });
}

/// @nodoc
class _$UserAchievementModelCopyWithImpl<
  $Res,
  $Val extends UserAchievementModel
>
    implements $UserAchievementModelCopyWith<$Res> {
  _$UserAchievementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? achievementId = null,
    Object? unlockedAt = null,
    Object? isViewed = null,
    Object? count = null,
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
            achievementId:
                null == achievementId
                    ? _value.achievementId
                    : achievementId // ignore: cast_nullable_to_non_nullable
                        as String,
            unlockedAt:
                null == unlockedAt
                    ? _value.unlockedAt
                    : unlockedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isViewed:
                null == isViewed
                    ? _value.isViewed
                    : isViewed // ignore: cast_nullable_to_non_nullable
                        as bool,
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAchievementModelImplCopyWith<$Res>
    implements $UserAchievementModelCopyWith<$Res> {
  factory _$$UserAchievementModelImplCopyWith(
    _$UserAchievementModelImpl value,
    $Res Function(_$UserAchievementModelImpl) then,
  ) = __$$UserAchievementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String achievementId,
    DateTime unlockedAt,
    bool isViewed,
    int count,
  });
}

/// @nodoc
class __$$UserAchievementModelImplCopyWithImpl<$Res>
    extends _$UserAchievementModelCopyWithImpl<$Res, _$UserAchievementModelImpl>
    implements _$$UserAchievementModelImplCopyWith<$Res> {
  __$$UserAchievementModelImplCopyWithImpl(
    _$UserAchievementModelImpl _value,
    $Res Function(_$UserAchievementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? achievementId = null,
    Object? unlockedAt = null,
    Object? isViewed = null,
    Object? count = null,
  }) {
    return _then(
      _$UserAchievementModelImpl(
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
        achievementId:
            null == achievementId
                ? _value.achievementId
                : achievementId // ignore: cast_nullable_to_non_nullable
                    as String,
        unlockedAt:
            null == unlockedAt
                ? _value.unlockedAt
                : unlockedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isViewed:
            null == isViewed
                ? _value.isViewed
                : isViewed // ignore: cast_nullable_to_non_nullable
                    as bool,
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAchievementModelImpl implements _UserAchievementModel {
  const _$UserAchievementModelImpl({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    this.isViewed = false,
    this.count = 1,
  });

  factory _$UserAchievementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAchievementModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String achievementId;
  @override
  final DateTime unlockedAt;
  @override
  @JsonKey()
  final bool isViewed;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'UserAchievementModel(id: $id, userId: $userId, achievementId: $achievementId, unlockedAt: $unlockedAt, isViewed: $isViewed, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAchievementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    achievementId,
    unlockedAt,
    isViewed,
    count,
  );

  /// Create a copy of UserAchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAchievementModelImplCopyWith<_$UserAchievementModelImpl>
  get copyWith =>
      __$$UserAchievementModelImplCopyWithImpl<_$UserAchievementModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAchievementModelImplToJson(this);
  }
}

abstract class _UserAchievementModel implements UserAchievementModel {
  const factory _UserAchievementModel({
    required final String id,
    required final String userId,
    required final String achievementId,
    required final DateTime unlockedAt,
    final bool isViewed,
    final int count,
  }) = _$UserAchievementModelImpl;

  factory _UserAchievementModel.fromJson(Map<String, dynamic> json) =
      _$UserAchievementModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get achievementId;
  @override
  DateTime get unlockedAt;
  @override
  bool get isViewed;
  @override
  int get count;

  /// Create a copy of UserAchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAchievementModelImplCopyWith<_$UserAchievementModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
