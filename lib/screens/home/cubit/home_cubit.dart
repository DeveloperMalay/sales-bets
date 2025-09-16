import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_bets/models/event/event_model.dart';
import 'package:sales_bets/models/team/team_model.dart';
import 'package:sales_bets/models/bet/bet_model.dart';
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

      // Load user data
      int userCredits = 1000; // Default
      int todayEarnings = 0;

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final userData = await _repository.getUser(user.uid);
          if (userData != null) {
            userCredits = userData.credits;

            // Calculate today's earnings from bets resolved today
            final userBets = await _repository.getUserBets(user.uid);
            todayEarnings = _calculateTodayEarnings(userBets);
          }
        } catch (e) {
          // If user data loading fails, use defaults
          debugPrint('Error loading user data: $e');
        }
      }

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          events: events,
          trendingTeams: trendingTeams,
          userCredits: userCredits,
          todayEarnings: todayEarnings,
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

  int _calculateTodayEarnings(List<BetModel> bets) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    int earnings = 0;
    for (final bet in bets) {
      if (bet.resolvedAt != null &&
          bet.resolvedAt!.isAfter(startOfDay) &&
          bet.resolvedAt!.isBefore(endOfDay) &&
          bet.status == BetStatus.won) {
        // Calculate net earnings (winnings - stake)
        earnings += bet.creditsWon - bet.creditsStaked;
      }
    }

    return earnings;
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
