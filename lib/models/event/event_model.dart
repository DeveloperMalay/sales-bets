import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

enum EventStatus { upcoming, live, completed, cancelled }

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String title,
    required String description,
    required List<String> teamIds,
    required DateTime startTime,
    DateTime? endTime,
    @Default(EventStatus.upcoming) EventStatus status,
    String? streamUrl,
    String? bannerImageUrl,
    @Default({}) Map<String, double> odds,
    String? winnerId,
    @Default(0) int totalBetsPlaced,
    @Default(0) int totalCreditsWagered,
    DateTime? createdAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}