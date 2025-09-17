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
      List<BetModel> userBets = [];

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final userData = await _repository.getUser(user.uid);
          if (userData != null) {
            userCredits = userData.credits;

            // Load user bets using the betIds from user data
            if (userData.betIds.isNotEmpty) {
              userBets = await _repository.getUserBetsByIds(userData.betIds);
            } else {
              userBets = [];
            }
            
            // Calculate today's earnings from bets resolved today
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
          userBets: userBets,
          userCredits: userCredits,
          todayEarnings: todayEarnings,
        ),
      );
      
      // Check for recently completed bets to show win/loss animations
      await _checkForRecentBetResults(userBets);
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

  // Check for recently completed bets to show win/loss animations
  Future<void> _checkForRecentBetResults(List<BetModel> userBets) async {
    try {
      final now = DateTime.now();
      final recentTimeThreshold = now.subtract(const Duration(minutes: 5)); // Check bets resolved in last 5 minutes
      
      for (final bet in userBets) {
        if (bet.resolvedAt != null && 
            bet.resolvedAt!.isAfter(recentTimeThreshold) &&
            bet.status != BetStatus.pending) {
          
          debugPrint('🎯 Found recent bet result:');
          debugPrint('  - Bet ID: ${bet.id}');
          debugPrint('  - Status: ${bet.status}');
          debugPrint('  - Resolved at: ${bet.resolvedAt}');
          debugPrint('  - Credits won: ${bet.creditsWon}');
          
          // Wait a moment for UI to load
          await Future.delayed(const Duration(milliseconds: 1000));
          
          if (bet.status == BetStatus.won) {
            showWinAnimation(bet.creditsWon);
          } else if (bet.status == BetStatus.lost) {
            showLoseAnimation();
          }
          
          // Only show animation for the most recent bet to avoid spam
          break;
        }
      }
    } catch (e) {
      debugPrint('Error checking recent bet results: $e');
    }
  }

  void showWinAnimation(int creditsWon) {
    debugPrint('🎉 Showing win animation on home screen: $creditsWon credits');
    emit(state.copyWith(
      status: HomeStatus.betWon,
      creditsWon: creditsWon,
    ));
  }

  void showLoseAnimation() {
    debugPrint('😔 Showing lose animation on home screen');
    emit(state.copyWith(
      status: HomeStatus.betLost,
    ));
  }

  void clearAnimation() {
    emit(state.copyWith(
      status: HomeStatus.loaded,
      creditsWon: null,
    ));
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
