part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, betWon, betLost, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<EventModel> events;
  final List<TeamModel> trendingTeams;
  final List<TeamModel> eventSpecificTeams;
  final List<BetModel> userBets;
  final int userCredits;
  final int todayEarnings;
  final int? creditsWon;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.events,
    required this.trendingTeams,
    required this.eventSpecificTeams,
    required this.userBets,
    required this.userCredits,
    required this.todayEarnings,
    this.creditsWon,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      errorMessage: null,
      events: [],
      trendingTeams: [],
      eventSpecificTeams: [],
      userBets: [],
      userCredits: 0,
      todayEarnings: 0,
      creditsWon: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    events,
    trendingTeams,
    eventSpecificTeams,
    userBets,
    userCredits,
    todayEarnings,
    creditsWon,
  ];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<EventModel>? events,
    List<TeamModel>? trendingTeams,
    List<TeamModel>? eventSpecificTeams,
    List<BetModel>? userBets,
    int? userCredits,
    int? todayEarnings,
    int? creditsWon,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      trendingTeams: trendingTeams ?? this.trendingTeams,
      eventSpecificTeams: eventSpecificTeams ?? this.eventSpecificTeams,
      userBets: userBets ?? this.userBets,
      userCredits: userCredits ?? this.userCredits,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      creditsWon: creditsWon ?? this.creditsWon,
    );
  }
}
