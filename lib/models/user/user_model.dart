import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String displayName,
    String? profileImageUrl,
    @Default(1000) int credits,
    @Default([]) List<String> followedTeamIds,
    @Default([]) List<String> betIds,
    @Default(0) int totalWins,
    @Default(0) int totalEarnings,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}