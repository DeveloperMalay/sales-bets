import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/event/event_model.dart';
import 'package:sales_bets/models/team/team_model.dart';
import 'package:sales_bets/services/api/firestore_repository.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirestoreRepository _repository;

  HomeCubit(this._repository) : super(HomeState.initial());

  Future<void> loadHomeData() async {
    emit(state.copyWith(status: HomeStatus.loading, errorMessage: null));
    try {
      // Load events (live and upcoming)
      final liveEvents = await _repository.getLiveEvents();
      final upcomingEvents = await _repository.getUpcomingEvents();

      // Load trending teams
      final trendingTeams = await _repository.getTrendingTeams(limit: 6);

      final events =
          [...liveEvents.take(2), ...upcomingEvents.take(3)].take(5).toList();

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          events: events,
          trendingTeams: trendingTeams,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Error loading home data: $e',
        ),
      );
    }
  }

  Future<void> getTeamsForEvent(EventModel event) async {
    try {
      final teams = await _repository.getTeamsForEvent(event);
      emit(
        state.copyWith(status: HomeStatus.loaded, eventSpecificTeams: teams),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Error loading teams for event: $e',
        ),
      );
    }
  }
}
