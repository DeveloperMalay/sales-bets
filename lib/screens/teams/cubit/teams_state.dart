part of 'teams_cubit.dart';

enum TeamStatus { initial, loading, loaded, error }

class TeamsState extends Equatable {
  final TeamStatus status;
  final String? errorMessage;
  final List<TeamModel> teams;
  final List<UserModel> leaderboard;

  const TeamsState({
    required this.status,
    required this.errorMessage,
    required this.teams,
    required this.leaderboard,
  });

  factory TeamsState.initial() {
    return const TeamsState(
      status: TeamStatus.initial,
      errorMessage: null,
      teams: [],
      leaderboard: [],
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, teams, leaderboard];

  TeamsState copyWith({
    TeamStatus? status,
    String? errorMessage,
    List<TeamModel>? teams,
    List<UserModel>? leaderboard,
  }) {
    return TeamsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      teams: teams ?? this.teams,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }
}
