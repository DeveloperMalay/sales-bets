part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<EventModel> events;
  final List<TeamModel> trendingTeams;
  final List<TeamModel> eventSpecificTeams;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.events,
    required this.trendingTeams,
    required this.eventSpecificTeams,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      errorMessage: null,
      events: [],
      trendingTeams: [],
      eventSpecificTeams: [],
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    events,
    trendingTeams,
    eventSpecificTeams,
  ];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<EventModel>? events,
    List<TeamModel>? trendingTeams,
    List<TeamModel>? eventSpecificTeams,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      trendingTeams: trendingTeams ?? this.trendingTeams,
      eventSpecificTeams: eventSpecificTeams ?? this.eventSpecificTeams,
    );
  }
}
