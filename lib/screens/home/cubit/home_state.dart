part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<EventModel> events;
  final List<TeamModel> trendingTeams;
  final List<TeamModel> eventSpecificTeams;
  final int userCredits;
  final int todayEarnings;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.events,
    required this.trendingTeams,
    required this.eventSpecificTeams,
    required this.userCredits,
    required this.todayEarnings,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      errorMessage: null,
      events: [],
      trendingTeams: [],
      eventSpecificTeams: [],
      userCredits: 0,
      todayEarnings: 0,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    events,
    trendingTeams,
    eventSpecificTeams,
    userCredits,
    todayEarnings,
  ];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<EventModel>? events,
    List<TeamModel>? trendingTeams,
    List<TeamModel>? eventSpecificTeams,
    int? userCredits,
    int? todayEarnings,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      trendingTeams: trendingTeams ?? this.trendingTeams,
      eventSpecificTeams: eventSpecificTeams ?? this.eventSpecificTeams,
      userCredits: userCredits ?? this.userCredits,
      todayEarnings: todayEarnings ?? this.todayEarnings,
    );
  }
}
