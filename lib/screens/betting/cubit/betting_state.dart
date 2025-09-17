part of 'betting_cubit.dart';

enum BettingStatus { 
  initial, 
  loading, 
  loaded, 
  placingBet, 
  betPlaced, 
  betWon, 
  betLost,
  error 
}

class BettingState extends Equatable {
  final BettingStatus status;
  final String? errorMessage;
  final EventModel? event;
  final List<TeamModel> teams;
  final BetModel? existingBet;
  final String? selectedTeamId;
  final int creditsToStake;
  final int userCredits;
  final int? creditsWon;

  const BettingState({
    required this.status,
    required this.errorMessage,
    required this.event,
    required this.teams,
    required this.existingBet,
    required this.selectedTeamId,
    required this.creditsToStake,
    required this.userCredits,
    this.creditsWon,
  });

  factory BettingState.initial() {
    return const BettingState(
      status: BettingStatus.initial,
      errorMessage: null,
      event: null,
      teams: [],
      existingBet: null,
      selectedTeamId: null,
      creditsToStake: 50,
      userCredits: 1000,
      creditsWon: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    event,
    teams,
    existingBet,
    selectedTeamId,
    creditsToStake,
    userCredits,
    creditsWon,
  ];

  BettingState copyWith({
    BettingStatus? status,
    String? errorMessage,
    EventModel? event,
    List<TeamModel>? teams,
    BetModel? existingBet,
    bool clearExistingBet = false,
    String? selectedTeamId,
    bool clearSelectedTeamId = false,
    int? creditsToStake,
    int? userCredits,
    int? creditsWon,
    bool clearCreditsWon = false,
  }) {
    return BettingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      event: event ?? this.event,
      teams: teams ?? this.teams,
      existingBet: clearExistingBet ? null : (existingBet ?? this.existingBet),
      selectedTeamId: clearSelectedTeamId ? null : (selectedTeamId ?? this.selectedTeamId),
      creditsToStake: creditsToStake ?? this.creditsToStake,
      userCredits: userCredits ?? this.userCredits,
      creditsWon: clearCreditsWon ? null : (creditsWon ?? this.creditsWon),
    );
  }
}