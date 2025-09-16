part of 'betting_bloc.dart';

abstract class BettingState extends Equatable {
  const BettingState();

  @override
  List<Object?> get props => [];
}

class BettingInitial extends BettingState {}

class BettingLoading extends BettingState {}

class BetPlaced extends BettingState {
  final BetModel bet;

  const BetPlaced({required this.bet});

  @override
  List<Object> get props => [bet];
}

class BetWon extends BettingState {
  final BetModel bet;
  final int creditsWon;

  const BetWon({required this.bet, required this.creditsWon});

  @override
  List<Object> get props => [bet, creditsWon];
}

class BetLost extends BettingState {
  final BetModel bet;

  const BetLost({required this.bet});

  @override
  List<Object> get props => [bet];
}

class UserBetsLoaded extends BettingState {
  final List<BetModel> bets;

  const UserBetsLoaded({required this.bets});

  @override
  List<Object> get props => [bets];
}

class BettingError extends BettingState {
  final String message;

  const BettingError({required this.message});

  @override
  List<Object> get props => [message];
}