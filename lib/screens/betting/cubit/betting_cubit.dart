import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../models/event/event_model.dart';
import '../../../models/team/team_model.dart';
import '../../../models/bet/bet_model.dart';
import '../../../services/api/firestore_repository.dart';

part 'betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  final FirestoreRepository _repository;

  BettingCubit(this._repository) : super(BettingState.initial());

  Future<void> loadBettingData(String eventId, String userId) async {
    emit(state.copyWith(
      status: BettingStatus.loading, 
      errorMessage: null,
      clearExistingBet: true, // Clear previous bet data
      clearSelectedTeamId: true, // Clear previous selection
      clearCreditsWon: true, // Clear previous win data
    ));
    
    try {
      // Load event details
      final event = await _repository.getEvent(eventId);
      if (event == null) {
        emit(state.copyWith(
          status: BettingStatus.error,
          errorMessage: 'Event not found',
        ));
        return;
      }

      // Load teams for this event
      final teams = await _repository.getTeamsForEvent(event);

      // Check for existing bet
      final existingBet = await _repository.getUserBetForEvent(userId, eventId);
      debugPrint('🎯 BettingCubit: existingBet result = ${existingBet?.id ?? "null"}');

      // Load user's current credits
      final user = await _repository.getUser(userId);
      final userCredits = user?.credits ?? 1000;

      emit(state.copyWith(
        status: BettingStatus.loaded,
        event: event,
        teams: teams,
        existingBet: existingBet, // This should be null if no bet found
        userCredits: userCredits,
      ));
      
      debugPrint('🎯 BettingCubit: State after emit - existingBet = ${state.existingBet?.id ?? "null"}');

      // Check if event is completed and user has a bet - show result animation
      if (event.status == EventStatus.completed && existingBet != null) {
        debugPrint('🎯 Event is completed and user has a bet:');
        debugPrint('  - Event status: ${event.status}');
        debugPrint('  - Bet status: ${existingBet.status}');
        debugPrint('  - Credits won: ${existingBet.creditsWon}');
        debugPrint('  - Team ID: ${existingBet.teamId}');
        debugPrint('  - Event winner: ${event.winnerId}');
        
        await Future.delayed(const Duration(milliseconds: 500)); // Small delay for UI to load
        _checkBetResult(existingBet, event);
      } else {
        debugPrint('🎯 Animation check failed:');
        debugPrint('  - Event status: ${event.status} (completed: ${event.status == EventStatus.completed})');
        debugPrint('  - Has existing bet: ${existingBet != null}');
        if (existingBet != null) {
          debugPrint('  - Bet status: ${existingBet.status}');
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: BettingStatus.error,
        errorMessage: 'Failed to load betting data: $e',
      ));
    }
  }

  void _checkBetResult(BetModel bet, EventModel event) {
    debugPrint('🎯 Checking bet result:');
    debugPrint('  - Bet status: ${bet.status}');
    debugPrint('  - Bet team ID: ${bet.teamId}');
    debugPrint('  - Event winner ID: ${event.winnerId}');
    debugPrint('  - Credits won: ${bet.creditsWon}');
    
    // Check both the bet status and also if the user's team matches the winner
    final userTeamWon = bet.teamId == event.winnerId;
    debugPrint('  - User team won: $userTeamWon');
    
    if (bet.status == BetStatus.won || (userTeamWon && bet.status == BetStatus.pending)) {
      debugPrint('🎉 User won bet! Showing celebration animation');
      final creditsToShow = bet.creditsWon > 0 ? bet.creditsWon : (bet.creditsStaked * 2); // fallback calculation
      emit(state.copyWith(
        status: BettingStatus.betWon,
        creditsWon: creditsToShow,
      ));
    } else if (bet.status == BetStatus.lost || (!userTeamWon && bet.status == BetStatus.pending)) {
      debugPrint('😔 User lost bet. Showing encouragement message');
      emit(state.copyWith(
        status: BettingStatus.betLost,
      ));
    } else {
      debugPrint('🤔 Bet result unclear - status: ${bet.status}, userTeamWon: $userTeamWon');
    }
  }

  void selectTeam(String teamId) {
    emit(state.copyWith(selectedTeamId: teamId));
  }

  void updateStakeAmount(int amount) {
    emit(state.copyWith(creditsToStake: amount));
  }

  Future<void> placeBet(String userId) async {
    debugPrint('🎲 BettingCubit: placeBet called with userId: $userId');
    debugPrint('🎲 Current state - selectedTeamId: ${state.selectedTeamId}');
    debugPrint('🎲 Current state - event: ${state.event?.id}');
    debugPrint('🎲 Current state - creditsToStake: ${state.creditsToStake}');
    
    if (state.selectedTeamId == null || state.event == null) {
      debugPrint('❌ BettingCubit: Missing team or event');
      emit(state.copyWith(
        status: BettingStatus.error,
        errorMessage: 'Please select a team first',
      ));
      return;
    }

    debugPrint('🎲 BettingCubit: Starting bet placement...');
    emit(state.copyWith(status: BettingStatus.placingBet));

    try {
      final bet = BetModel(
        id: const Uuid().v4(),
        userId: userId,
        eventId: state.event!.id,
        teamId: state.selectedTeamId!,
        creditsStaked: state.creditsToStake,
        odds: _getTeamOdds(state.selectedTeamId!),
        placedAt: DateTime.now(),
      );

      debugPrint('🎲 BettingCubit: Bet created - ${bet.id}');
      debugPrint('🎲 BettingCubit: Calling repository.placeBet...');
      
      await _repository.placeBet(bet);

      debugPrint('✅ BettingCubit: Bet placed successfully!');
      emit(state.copyWith(
        status: BettingStatus.betPlaced,
        existingBet: bet,
        selectedTeamId: null, // Clear selection
      ));
    } catch (e) {
      debugPrint('❌ BettingCubit: Error placing bet: $e');
      emit(state.copyWith(
        status: BettingStatus.error,
        errorMessage: 'Failed to place bet: $e',
      ));
    }
  }

  double _getTeamOdds(String teamId) {
    if (state.event == null) return 2.0;
    return state.event!.odds[teamId] ?? 2.0;
  }

  String? getSelectedTeamName() {
    if (state.selectedTeamId == null) return null;
    return state.teams
        .firstWhere((team) => team.id == state.selectedTeamId)
        .name;
  }

  TeamModel? getTeamById(String teamId) {
    try {
      return state.teams.firstWhere((team) => team.id == teamId);
    } catch (e) {
      return null;
    }
  }

  int calculatePotentialWinnings() {
    if (state.selectedTeamId == null) return 0;
    final odds = _getTeamOdds(state.selectedTeamId!);
    return (state.creditsToStake * odds).round();
  }

  int calculateNetProfit() {
    final totalWinnings = calculatePotentialWinnings();
    return totalWinnings - state.creditsToStake;
  }

  void clearError() {
    emit(state.copyWith(
      status: BettingStatus.loaded,
      errorMessage: null,
    ));
  }

  void celebrateWin(int creditsWon) {
    emit(state.copyWith(
      status: BettingStatus.betWon,
      creditsWon: creditsWon,
    ));
  }

  void clearWinCelebration() {
    emit(state.copyWith(
      status: BettingStatus.loaded,
      creditsWon: null,
    ));
  }
}