part of 'teams_cubit.dart';

enum TeamStatus { initial, loading, loaded, error }

class TeamsState extends Equatable {
  final TeamStatus status;
  final String? errorMessage;
  final List<TeamModel> teams;

  const TeamsState({
    required this.status,
    required this.errorMessage,
    required this.teams,
  });

  factory TeamsState.initial() {
    return const TeamsState(
      status: TeamStatus.initial,
      errorMessage: null,
      teams: [],
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, teams];

  TeamsState copyWith({
    TeamStatus? status,
    String? errorMessage,
    List<TeamModel>? teams,
  }) {
    return TeamsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      teams: teams ?? this.teams,
    );
  }
}
