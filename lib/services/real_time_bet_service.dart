import 'dart:async';
import 'package:flutter/material.dart';
import '../models/bet/bet_model.dart';
import '../models/event/event_model.dart';
import 'api/firestore_repository.dart';
import 'notification_service.dart';
import 'achievement_service.dart';
import 'push_notification_service.dart';

class RealTimeBetService {
  static final RealTimeBetService _instance = RealTimeBetService._internal();
  factory RealTimeBetService() => _instance;
  RealTimeBetService._internal();

  final FirestoreRepository _repository = FirestoreRepository();
  final AchievementService _achievementService = AchievementService();
  final PushNotificationService _pushNotificationService =
      PushNotificationService();
  StreamSubscription<List<BetModel>>? _betsSubscription;
  StreamSubscription<List<EventModel>>? _eventsSubscription;
  BuildContext? _context;
  String? _currentUserId;
  List<BetModel> _previousBets = [];

  // Initialize the service
  void initialize(BuildContext context, String userId) {
    _context = context;
    _currentUserId = userId;
    _initializePushNotifications();
    _startListening();
  }

  void _initializePushNotifications() async {
    await _pushNotificationService.initialize();
    // Subscribe to user-specific notifications
    if (_currentUserId != null) {
      await _pushNotificationService.subscribeToTopic('user_$_currentUserId');
    }
  }

  // Clean up resources
  void dispose() {
    _betsSubscription?.cancel();
    _eventsSubscription?.cancel();
    _context = null;
    _currentUserId = null;
    _previousBets.clear();
  }

  void _startListening() {
    if (_currentUserId == null) return;

    // Listen to user's bets for real-time updates
    _betsSubscription = _repository
        .getBetsStream(_currentUserId!)
        .listen(
          (bets) {
            _handleBetUpdates(bets);
          },
          onError: (error) {
            debugPrint('Error listening to bets: $error');
          },
        );

    // Listen to events for completion notifications
    _eventsSubscription = _repository.getEventsStream().listen(
      (events) {
        _handleEventUpdates(events);
      },
      onError: (error) {
        debugPrint('Error listening to events: $error');
      },
    );
  }

  void _handleBetUpdates(List<BetModel> currentBets) {
    if (_context == null) return;

    // Check for newly resolved bets
    for (final bet in currentBets) {
      final previousBet = _previousBets.firstWhere(
        (p) => p.id == bet.id,
        orElse: () => bet, // If not found, use current bet (it's new)
      );

      // If bet status changed from pending to resolved
      if (previousBet.status == BetStatus.pending &&
          (bet.status == BetStatus.won || bet.status == BetStatus.lost)) {
        _showBetResolutionNotification(bet);
      }
    }

    _previousBets = List.from(currentBets);
  }

  void _handleEventUpdates(List<EventModel> events) {
    // Handle event completion notifications if needed
    for (final event in events) {
      if (event.status == EventStatus.completed && event.winnerId != null) {
        // Event just completed - bets will be resolved automatically
        debugPrint(
          'Event ${event.title} completed with winner: ${event.winnerId}',
        );
      }
    }
  }

  Future<void> _showBetResolutionNotification(BetModel bet) async {
    if (_context == null || _currentUserId == null) return;

    try {
      // Get event and team details for better notification
      final event = await _repository.getEvent(bet.eventId);
      final team = await _repository.getTeam(bet.teamId);

      // Show in-app notification
      NotificationService.showBetOutcomeNotification(
        _context!,
        bet,
        eventTitle: event?.title,
        teamName: team?.name,
      );

      // Send push notification
      await _pushNotificationService.sendBetResultNotification(
        userId: _currentUserId!,
        bet: bet,
        eventTitle: event?.title ?? 'Event',
        teamName: team?.name ?? 'Team',
        isWin: bet.status == BetStatus.won,
      );

      // Check for new achievements
      final user = await _repository.getUser(_currentUserId!);
      final allUserBets = await _repository.getUserBets(_currentUserId!);

      if (user != null) {
        final newAchievements = await _achievementService.checkAchievements(
          _currentUserId!,
          user,
          allUserBets,
          latestBet: bet,
          context: _context,
        );

        // Send push notifications for achievements
        for (final achievement in newAchievements) {
          await _pushNotificationService.sendAchievementNotification(
            userId: _currentUserId!,
            achievementTitle: achievement.title,
            achievementDescription: achievement.description,
            rewardCredits: achievement.rewardCredits,
          );
        }

        debugPrint(
          'Checked achievements after bet resolution. Found ${newAchievements.length} new achievements.',
        );
      }
    } catch (e) {
      // Fallback notification without details
      NotificationService.showBetOutcomeNotification(_context!, bet);
      debugPrint('Error in bet resolution notification: $e');
    }
  }

  // Complete an event and resolve all its bets
  Future<void> completeEventForTesting(String eventId, String winnerId) async {
    try {
      await _repository.completeEvent(eventId, winnerId);
      debugPrint('Completed event $eventId with winner $winnerId');
    } catch (e) {
      debugPrint('Error completing event: $e');
    }
  }

  // Get current user's active bets count
  Stream<int> getActiveBetsCountStream() {
    if (_currentUserId == null) {
      return Stream.value(0);
    }

    return _repository.getBetsStream(_currentUserId!).map((bets) {
      return bets.where((bet) => bet.status == BetStatus.pending).length;
    });
  }

  // Get real-time user stats
  Stream<Map<String, int>> getUserStatsStream() {
    if (_currentUserId == null) {
      return Stream.value({'wins': 0, 'losses': 0, 'pending': 0});
    }

    return _repository.getBetsStream(_currentUserId!).map((bets) {
      final wins = bets.where((bet) => bet.status == BetStatus.won).length;
      final losses = bets.where((bet) => bet.status == BetStatus.lost).length;
      final pending =
          bets.where((bet) => bet.status == BetStatus.pending).length;

      return {'wins': wins, 'losses': losses, 'pending': pending};
    });
  }

  // Check achievements when a new bet is placed
  Future<void> checkAchievementsForNewBet(BetModel bet) async {
    if (_currentUserId == null || _context == null) return;

    try {
      final user = await _repository.getUser(_currentUserId!);
      final allUserBets = await _repository.getUserBets(_currentUserId!);

      if (user != null) {
        await _achievementService.checkAchievements(
          _currentUserId!,
          user,
          allUserBets,
          latestBet: bet,
          context: _context,
        );
      }
    } catch (e) {
      debugPrint('Error checking achievements for new bet: $e');
    }
  }

  // Initialize achievements in Firestore (call once)
  Future<void> initializeAchievements() async {
    await _achievementService.initializeAchievements();
  }
}
