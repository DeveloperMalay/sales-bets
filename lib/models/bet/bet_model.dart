import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_model.freezed.dart';
part 'bet_model.g.dart';

enum BetStatus { pending, won, lost }

@freezed
class BetModel with _$BetModel {
  const factory BetModel({
    required String id,
    required String userId,
    required String eventId,
    required String teamId,
    required int creditsStaked,
    @Default(BetStatus.pending) BetStatus status,
    @Default(0) int creditsWon,
    double? odds,
    DateTime? placedAt,
    DateTime? resolvedAt,
  }) = _BetModel;

  factory BetModel.fromJson(Map<String, dynamic> json) =>
      _$BetModelFromJson(json);
}