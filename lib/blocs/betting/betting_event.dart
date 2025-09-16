part of 'betting_bloc.dart';

abstract class BettingEvent extends Equatable {
  const BettingEvent();

  @override
  List<Object?> get props => [];
}

class PlaceBetRequested extends BettingEvent {
  final String userId;
  final String eventId;
  final String teamId;
  final int creditsStaked;
  final double? odds;

  const PlaceBetRequested({
    required this.userId,
    required this.eventId,
    required this.teamId,
    required this.creditsStaked,
    this.odds,
  });

  @override
  List<Object?> get props => [userId, eventId, teamId, creditsStaked, odds];
}

class LoadUserBets extends BettingEvent {
  final String userId;

  const LoadUserBets({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ResolveBetRequested extends BettingEvent {
  final BetModel bet;
  final bool isWin;

  const ResolveBetRequested({
    required this.bet,
    required this.isWin,
  });

  @override
  List<Object> get props => [bet, isWin];
}