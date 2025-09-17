import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user/user_model.dart';
import '../../models/team/team_model.dart';
import '../../models/event/event_model.dart';
import '../../models/bet/bet_model.dart';
import '../../models/stream/stream_model.dart';
import 'firebase_service.dart';

class FirestoreRepository {
  // Helper function to convert Firestore data with proper Timestamp handling
  Map<String, dynamic> _convertFirestoreData(Map<String, dynamic> data) {
    final convertedData = <String, dynamic>{};

    for (final entry in data.entries) {
      if (entry.value is Timestamp) {
        convertedData[entry.key] =
            (entry.value as Timestamp).toDate().toIso8601String();
      } else {
        convertedData[entry.key] = entry.value;
      }
    }

    return convertedData;
  }

  // Team operations
  Future<List<TeamModel>> getAllTeams() async {
    try {
      final querySnapshot =
          await FirebaseService.firestore.collection('teams').get();
      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting teams: $e');
      return [];
    }
  }

  Future<TeamModel?> getTeam(String teamId) async {
    try {
      final doc =
          await FirebaseService.firestore.collection('teams').doc(teamId).get();
      if (doc.exists) {
        return TeamModel.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting team: $e');
      return null;
    }
  }

  Future<List<TeamModel>> getTrendingTeams({int limit = 6}) async {
    try {
      final querySnapshot =
          await FirebaseService.firestore
              .collection('teams')
              .orderBy('followers', descending: true)
              .limit(limit)
              .get();
      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting trending teams: $e');
      return [];
    }
  }

  Future<List<TeamModel>> getTopTeams({int limit = 6}) async {
    try {
      final querySnapshot =
          await FirebaseService.firestore
              .collection('teams')
              .orderBy('wins', descending: true)
              .limit(limit)
              .get();
      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting top teams: $e');
      return [];
    }
  }

  // Event operations
  Future<List<EventModel>> getAllEvents() async {
    try {
      final querySnapshot =
          await FirebaseService.firestore.collection('events').get();
      return querySnapshot.docs.map((doc) {
        final data = _convertFirestoreData(doc.data());
        return EventModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      debugPrint('Error getting events: $e');
      return [];
    }
  }

  Future<List<EventModel>> getLiveEvents() async {
    try {
      final querySnapshot =
          await FirebaseService.firestore
              .collection('events')
              .where('status', isEqualTo: 'live')
              .get();
      return querySnapshot.docs.map((doc) {
        final data = _convertFirestoreData(doc.data());
        return EventModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      debugPrint('Error getting live events: $e');
      return [];
    }
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    try {
      // Get all events first, then filter and sort in code to avoid index requirement
      final querySnapshot =
          await FirebaseService.firestore.collection('events').get();

      final allEvents =
          querySnapshot.docs.map((doc) {
            final data = _convertFirestoreData(doc.data());
            return EventModel.fromJson({...data, 'id': doc.id});
          }).toList();

      // Filter for upcoming events and sort by startTime
      return allEvents
          .where((event) => event.status == EventStatus.upcoming)
          .toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
    } catch (e) {
      debugPrint('Error getting upcoming events: $e');
      return [];
    }
  }

  Future<EventModel?> getEvent(String eventId) async {
    try {
      final doc =
          await FirebaseService.firestore
              .collection('events')
              .doc(eventId)
              .get();
      if (doc.exists) {
        final data = _convertFirestoreData(doc.data()!);
        return EventModel.fromJson({...data, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting event: $e');
      return null;
    }
  }

  Future<List<TeamModel>> getTeamsForEvent(EventModel event) async {
    try {
      if (event.teamIds.isEmpty) return [];

      final querySnapshot =
          await FirebaseService.firestore
              .collection('teams')
              .where(FieldPath.documentId, whereIn: event.teamIds)
              .get();

      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting teams for event: $e');
      return [];
    }
  }

  // Stream operations
  Future<List<StreamModel>> getAllStreams() async {
    try {
      final querySnapshot =
          await FirebaseService.firestore.collection('streams').get();
      return querySnapshot.docs
          .map((doc) => StreamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting streams: $e');
      return [];
    }
  }

  Future<List<StreamModel>> getLiveStreams() async {
    try {
      // Get all streams first, then filter and sort in code to avoid index requirement
      final querySnapshot =
          await FirebaseService.firestore.collection('streams').get();

      final allStreams =
          querySnapshot.docs
              .map((doc) => StreamModel.fromJson({...doc.data(), 'id': doc.id}))
              .toList();

      // Filter for live streams and sort by viewerCount
      return allStreams.where((stream) => stream.isLive).toList()
        ..sort((a, b) => b.viewerCount.compareTo(a.viewerCount));
    } catch (e) {
      debugPrint('Error getting live streams: $e');
      return [];
    }
  }

  Future<StreamModel?> getStream(String streamId) async {
    try {
      final doc =
          await FirebaseService.firestore
              .collection('streams')
              .doc(streamId)
              .get();
      if (doc.exists) {
        return StreamModel.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting stream: $e');
      return null;
    }
  }

  // User operations
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await FirebaseService.usersCollection.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  // Get leaderboard - top users by total earnings
  Future<List<UserModel>> getLeaderboard({int limit = 20}) async {
    try {
      final query =
          await FirebaseService.usersCollection
              .orderBy('totalEarnings', descending: true)
              .limit(limit)
              .get();

      return query.docs
          .map(
            (doc) => UserModel.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            }),
          )
          .toList();
    } catch (e) {
      debugPrint('Error getting leaderboard: $e');
      return [];
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await FirebaseService.usersCollection.doc(user.id).update(user.toJson());
    } catch (e) {
      debugPrint('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> updateUserCredits(String userId, int newCredits) async {
    try {
      await FirebaseService.usersCollection.doc(userId).update({
        'credits': newCredits,
      });
    } catch (e) {
      debugPrint('Error updating user credits: $e');
      rethrow;
    }
  }

  Future<void> followTeam(String userId, String teamId) async {
    try {
      await FirebaseService.usersCollection.doc(userId).update({
        'followedTeamIds': FieldValue.arrayUnion([teamId]),
      });

      // Update team followers count
      await FirebaseService.teamsCollection.doc(teamId).update({
        'followers': FieldValue.increment(1),
      });
    } catch (e) {
      debugPrint('Error following team: $e');
      rethrow;
    }
  }

  Future<void> unfollowTeam(String userId, String teamId) async {
    try {
      await FirebaseService.usersCollection.doc(userId).update({
        'followedTeamIds': FieldValue.arrayRemove([teamId]),
      });

      // Update team followers count
      await FirebaseService.teamsCollection.doc(teamId).update({
        'followers': FieldValue.increment(-1),
      });
    } catch (e) {
      debugPrint('Error unfollowing team: $e');
      rethrow;
    }
  }

  // Team operations
  Future<List<TeamModel>> getTeams({int limit = 20}) async {
    try {
      final query =
          await FirebaseService.teamsCollection
              .orderBy('followers', descending: true)
              .limit(limit)
              .get();

      return query.docs
          .map((doc) => TeamModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting teams: $e');
      return [];
    }
  }

  Stream<List<TeamModel>> getTeamsStream() {
    return FirebaseService.teamsCollection
        .orderBy('followers', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        TeamModel.fromJson(doc.data() as Map<String, dynamic>),
                  )
                  .toList(),
        );
  }

  // Event operations
  Future<List<EventModel>> getEvents({int limit = 20}) async {
    try {
      final query =
          await FirebaseService.eventsCollection
              .orderBy('startTime', descending: false)
              .limit(limit)
              .get();

      return query.docs.map((doc) {
        final data = _convertFirestoreData(doc.data() as Map<String, dynamic>);
        return EventModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      debugPrint('Error getting events: $e');
      return [];
    }
  }

  Stream<List<EventModel>> getEventsStream() {
    return FirebaseService.eventsCollection
        .orderBy('startTime', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = _convertFirestoreData(
                  doc.data() as Map<String, dynamic>,
                );
                return EventModel.fromJson({...data, 'id': doc.id});
              }).toList(),
        );
  }

  // Real-time bet updates
  Stream<List<BetModel>> getBetsStream(String userId) {
    return FirebaseService.betsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('placedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) => BetModel.fromJson({
                  ...doc.data() as Map<String, dynamic>,
                  'id': doc.id,
                }),
              )
              .toList();
        });
  }

  Stream<BetModel?> getBetStream(String betId) {
    return FirebaseService.betsCollection.doc(betId).snapshots().map((doc) {
      if (doc.exists) {
        return BetModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }
      return null;
    });
  }

  // Betting operations
  Future<void> placeBet(BetModel bet) async {
    try {
      // Start a batch write
      final batch = FirebaseService.firestore.batch();

      // Add bet document to global bets collection
      final betRef = FirebaseService.betsCollection.doc(bet.id);
      batch.set(betRef, bet.toJson());

      // Update user's bet IDs and credits (no-loss mechanic - credits don't decrease)
      final userRef = FirebaseService.usersCollection.doc(bet.userId);
      batch.update(userRef, {
        'betIds': FieldValue.arrayUnion([bet.id]),
      });

      // Update event's total bets
      final eventRef = FirebaseService.eventsCollection.doc(bet.eventId);
      batch.update(eventRef, {
        'totalBetsPlaced': FieldValue.increment(1),
        'totalCreditsWagered': FieldValue.increment(bet.creditsStaked),
      });

      await batch.commit();
    } catch (e) {
      debugPrint('Error placing bet: $e');
      rethrow;
    }
  }

  Future<List<BetModel>> getUserBets(String userId) async {
    try {
      debugPrint('Getting bets for user: $userId');
      final query =
          await FirebaseService.betsCollection
              .where('userId', isEqualTo: userId)
              .get();

      debugPrint('Found ${query.docs.length} bet documents for user $userId');

      final bets =
          query.docs
              .map((doc) {
                final data = doc.data();
                if (data == null) return null;
                debugPrint(
                  'Processing bet document ${doc.id}: ${data.toString()}',
                );
                return BetModel.fromJson({
                  ..._convertFirestoreData(data as Map<String, dynamic>),
                  'id': doc.id,
                });
              })
              .whereType<BetModel>()
              .toList();

      debugPrint('Successfully parsed ${bets.length} bets');

      // Sort by placedAt in code to avoid index requirement
      bets.sort((a, b) {
        final aTime = a.placedAt;
        final bTime = b.placedAt;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });
      return bets;
    } catch (e) {
      debugPrint('Error getting user bets: $e');
      return [];
    }
  }

  // Get user bets by specific bet IDs (from user's betIds array)
  Future<List<BetModel>> getUserBetsByIds(List<String> betIds) async {
    try {
      if (betIds.isEmpty) {
        debugPrint('No bet IDs provided');
        return [];
      }

      debugPrint('Getting bets by IDs: $betIds');

      // Firestore 'in' queries are limited to 10 items, so we need to batch them
      final bets = <BetModel>[];

      // Process in chunks of 10
      for (int i = 0; i < betIds.length; i += 10) {
        final chunk = betIds.skip(i).take(10).toList();
        debugPrint('Processing chunk: $chunk');

        final query =
            await FirebaseService.betsCollection
                .where(FieldPath.documentId, whereIn: chunk)
                .get();

        debugPrint('Found ${query.docs.length} bet documents in chunk');

        final chunkBets =
            query.docs
                .map((doc) {
                  final data = doc.data();
                  if (data == null) return null;
                  debugPrint(
                    'Processing bet document ${doc.id}: ${data.toString()}',
                  );
                  return BetModel.fromJson({
                    ..._convertFirestoreData(data as Map<String, dynamic>),
                    'id': doc.id,
                  });
                })
                .whereType<BetModel>()
                .toList();

        bets.addAll(chunkBets);
      }

      debugPrint('Successfully parsed ${bets.length} bets from bet IDs');

      // Sort by placedAt in code
      bets.sort((a, b) {
        final aTime = a.placedAt;
        final bTime = b.placedAt;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });

      return bets;
    } catch (e) {
      debugPrint('Error getting user bets by IDs: $e');
      return [];
    }
  }

  // Check if user has already bet on a specific event
  Future<BetModel?> getUserBetForEvent(String userId, String eventId) async {
    try {
      debugPrint('🔍 Checking bet for user $userId on event $eventId');

      // First, get the user to check their betIds array
      final userData = await getUser(userId);
      if (userData == null || userData.betIds.isEmpty) {
        debugPrint('🔍 User has no bet IDs or user not found');
        return null;
      }

      debugPrint(
        '🔍 User has ${userData.betIds.length} bet IDs: ${userData.betIds}',
      );

      // Load all user's bets using their betIds
      final userBets = await getUserBetsByIds(userData.betIds);

      // Find bet for this specific event
      final bet = userBets.cast<BetModel?>().firstWhere(
        (bet) => bet?.eventId == eventId,
        orElse: () => null,
      );

      if (bet != null) {
        debugPrint('✅ Found bet ${bet.id} for event $eventId');
      } else {
        debugPrint('❌ No bet found for event $eventId');
      }

      return bet;
    } catch (e) {
      debugPrint('Error checking user bet for event: $e');
      return null;
    }
  }

  // Automatic event resolution and bet processing
  Future<void> resolveEventBets(String eventId, String winnerId) async {
    try {
      debugPrint('Resolving bets for event: $eventId, winner: $winnerId');

      // Get all bets for this event
      final betsQuery =
          await FirebaseService.betsCollection
              .where('eventId', isEqualTo: eventId)
              .where('status', isEqualTo: 'pending')
              .get();

      if (betsQuery.docs.isEmpty) {
        debugPrint('No pending bets found for event: $eventId');
        return;
      }

      final batch = FirebaseService.firestore.batch();
      final userUpdates = <String, Map<String, dynamic>>{};

      for (final doc in betsQuery.docs) {
        final betData = doc.data() as Map<String, dynamic>;
        final bet = BetModel.fromJson({...betData, 'id': doc.id});

        final isWinner = bet.teamId == winnerId;
        final newStatus = isWinner ? BetStatus.won : BetStatus.lost;
        final creditsWon =
            isWinner
                ? (bet.creditsStaked * (bet.odds ?? 1.0)).round()
                : 0; // Use actual odds, default odds to 1.0 if null

        // Update bet document
        batch.update(doc.reference, {
          'status': newStatus.name,
          'creditsWon': creditsWon,
          'resolvedAt': FieldValue.serverTimestamp(),
        });

        // Prepare user updates
        final userId = bet.userId;
        userUpdates.putIfAbsent(userId, () => {});
        if (isWinner) {
          userUpdates[userId]!['totalWins'] = FieldValue.increment(1);
          // Calculate net winnings (profit only, not including original stake)
          final netWinnings = creditsWon - bet.creditsStaked;
          userUpdates[userId]!['totalEarnings'] = FieldValue.increment(
            netWinnings,
          );
          // Only add the net winnings to credits (no-loss mechanic)
          userUpdates[userId]!['credits'] = FieldValue.increment(netWinnings);
        } else {
          userUpdates[userId]!['totalLosses'] = FieldValue.increment(1);
          // No credit deduction for losses (no-loss mechanic)
        }
      }

      // Update all users' stats
      for (final entry in userUpdates.entries) {
        final userRef = FirebaseService.usersCollection.doc(entry.key);
        batch.update(userRef, entry.value);
      }

      // Note: Event status is updated separately in completeEvent function

      await batch.commit();
      debugPrint(
        'Successfully resolved ${betsQuery.docs.length} bets for event: $eventId',
      );
    } catch (e) {
      debugPrint('Error resolving event bets: $e');
      rethrow;
    }
  }

  // Listen for event status changes and auto-resolve bets
  Stream<List<EventModel>> getCompletedEventsStream() {
    return FirebaseService.eventsCollection
        .where('status', isEqualTo: EventStatus.completed.name)
        .where(
          'endTime',
          isGreaterThan: Timestamp.fromDate(
            DateTime.now().subtract(const Duration(minutes: 5)),
          ),
        )
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) => EventModel.fromJson({
                  ...doc.data() as Map<String, dynamic>,
                  'id': doc.id,
                }),
              )
              .toList();
        });
  }

  // Mark event as completed and trigger bet resolution
  Future<void> completeEvent(String eventId, String winnerId) async {
    try {
      debugPrint('Completing event: $eventId with winner: $winnerId');

      // First, just update the event status and winner
      await FirebaseService.eventsCollection.doc(eventId).update({
        'status': EventStatus.completed.name,
        'winnerId': winnerId,
        'endTime': FieldValue.serverTimestamp(),
      });

      debugPrint('Event status updated successfully');

      // Then resolve bets separately to avoid batch conflicts
      await resolveEventBets(eventId, winnerId);

      debugPrint('Event completed successfully: $eventId');
    } catch (e) {
      debugPrint('Error completing event: $e');
      rethrow;
    }
  }

  Stream<List<StreamModel>> getLiveStreamsStream() {
    return FirebaseService.streamsCollection
        .where('isLive', isEqualTo: true)
        .orderBy('viewerCount', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => StreamModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  Future<void> addChatMessage(String streamId, ChatMessage message) async {
    try {
      await FirebaseService.streamsCollection.doc(streamId).update({
        'chatMessages': FieldValue.arrayUnion([message.toJson()]),
      });
    } catch (e) {
      debugPrint('Error adding chat message: $e');
      rethrow;
    }
  }
}
