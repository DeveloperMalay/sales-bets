import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../../models/bet/bet_model.dart';
import '../../../services/api/firestore_repository.dart';

part 'betting_event.dart';
part 'betting_state.dart';

class BettingBloc extends Bloc<BettingEvent, BettingState> {
  final FirestoreRepository repository;
  
  BettingBloc({required this.repository}) : super(BettingInitial()) {
    on<PlaceBetRequested>(_onPlaceBetRequested);
    on<LoadUserBets>(_onLoadUserBets);
    on<ResolveBetRequested>(_onResolveBetRequested);
  }

  void _onPlaceBetRequested(
    PlaceBetRequested event,
    Emitter<BettingState> emit,
  ) async {
    emit(BettingLoading());
    
    try {
      // Create new bet with no-loss mechanic
      final bet = BetModel(
        id: const Uuid().v4(),
        userId: event.userId,
        eventId: event.eventId,
        teamId: event.teamId,
        creditsStaked: event.creditsStaked,
        odds: event.odds,
        placedAt: DateTime.now(),
      );
      
      // Place bet in Firestore (credits don't decrease!)
      await repository.placeBet(bet);
      
      emit(BetPlaced(bet: bet));
    } catch (e) {
      emit(BettingError(message: 'Failed to place bet: $e'));
    }
  }

  void _onLoadUserBets(
    LoadUserBets event,
    Emitter<BettingState> emit,
  ) async {
    emit(BettingLoading());
    
    try {
      final bets = await repository.getUserBets(event.userId);
      emit(UserBetsLoaded(bets: bets));
    } catch (e) {
      emit(BettingError(message: 'Failed to load bets: $e'));
    }
  }

  void _onResolveBetRequested(
    ResolveBetRequested event,
    Emitter<BettingState> emit,
  ) async {
    try {
      // Resolve bet (admin functionality)
      final creditsWon = event.isWin 
          ? _calculateWinnings(event.bet.creditsStaked, event.bet.odds ?? 2.0)
          : 0;
      
      await repository.resolveBet(
        event.bet.id, 
        event.isWin ? BetStatus.won : BetStatus.lost,
        creditsWon,
      );
      
      if (event.isWin && creditsWon > 0) {
        emit(BetWon(bet: event.bet, creditsWon: creditsWon));
      } else {
        emit(BetLost(bet: event.bet));
      }
    } catch (e) {
      emit(BettingError(message: 'Failed to resolve bet: $e'));
    }
  }

  int _calculateWinnings(int creditsStaked, double odds) {
    return (creditsStaked * odds).round();
  }
}