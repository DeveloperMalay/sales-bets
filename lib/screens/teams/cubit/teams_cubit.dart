import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/team/team_model.dart';
import 'package:sales_bets/models/user/user_model.dart';
import 'package:sales_bets/services/api/firestore_repository.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final FirestoreRepository _repository;
  TeamsCubit(this._repository) : super(TeamsState.initial());

  Future<void> getTeams() async {
    emit(state.copyWith(status: TeamStatus.loading, errorMessage: null));
    try {
      final teams = await _repository.getAllTeams();
      final leaderboard = await _repository.getLeaderboard(limit: 10);
      emit(state.copyWith(
        status: TeamStatus.loaded, 
        teams: teams,
        leaderboard: leaderboard,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: TeamStatus.error,
          errorMessage: 'Error loading teams: $e',
        ),
      );
    }
  }
}
