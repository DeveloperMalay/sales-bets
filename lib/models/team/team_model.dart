import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String description,
    String? logoUrl,
    String? bannerImageUrl,
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int followers,
    @Default(0) int totalEarnings,
    @Default([]) List<String> athleteIds,
    @Default([]) List<String> achievements,
    @Default(false) bool isLive,
    String? currentStreamUrl,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}