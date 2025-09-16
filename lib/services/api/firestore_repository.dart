import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user/user_model.dart';
import '../../models/team/team_model.dart';
import '../../models/event/event_model.dart';
import '../../models/bet/bet_model.dart';
import '../../models/stream/stream_model.dart';
import 'firebase_service.dart';

class FirestoreRepository {
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
      return querySnapshot.docs
          .map((doc) => EventModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
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
      return querySnapshot.docs
          .map((doc) => EventModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      debugPrint('Error getting live events: $e');
      return [];
    }
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    try {
      final querySnapshot =
          await FirebaseService.firestore
              .collection('events')
              .where('status', isEqualTo: 'upcoming')
              .orderBy('startTime')
              .get();
      return querySnapshot.docs
          .map((doc) => EventModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
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
        return EventModel.fromJson({...doc.data()!, 'id': doc.id});
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
      final querySnapshot =
          await FirebaseService.firestore
              .collection('streams')
              .where('isLive', isEqualTo: true)
              .orderBy('viewerCount', descending: true)
              .get();
      return querySnapshot.docs
          .map((doc) => StreamModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
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

  // Future<TeamModel?> getTeam(String teamId) async {
  //   try {
  //     final doc = await FirebaseService.teamsCollection.doc(teamId).get();
  //     if (doc.exists) {
  //       return TeamModel.fromJson(doc.data() as Map<String, dynamic>);
  //     }
  //     return null;
  //   } catch (e) {
  //     debugPrint('Error getting team: $e');
  //     return null;
  //   }
  // }

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

      return query.docs
          .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting events: $e');
      return [];
    }
  }

  // Future<List<EventModel>> getLiveEvents() async {
  //   try {
  //     final query =
  //         await FirebaseService.eventsCollection
  //             .where('status', isEqualTo: EventStatus.live.name)
  //             .orderBy('startTime', descending: false)
  //             .get();

  //     return query.docs
  //         .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     debugdebugPrint('Error getting live events: $e');
  //     return [];
  //   }
  // }

  Stream<List<EventModel>> getEventsStream() {
    return FirebaseService.eventsCollection
        .orderBy('startTime', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        EventModel.fromJson(doc.data() as Map<String, dynamic>),
                  )
                  .toList(),
        );
  }

  // Betting operations
  Future<void> placeBet(BetModel bet) async {
    try {
      // Start a batch write
      final batch = FirebaseService.firestore.batch();

      // Add bet document
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
      final query =
          await FirebaseService.betsCollection
              .where('userId', isEqualTo: userId)
              .orderBy('placedAt', descending: true)
              .get();

      return query.docs
          .map((doc) => BetModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting user bets: $e');
      return [];
    }
  }

  Future<void> resolveBet(
    String betId,
    BetStatus status,
    int creditsWon,
  ) async {
    try {
      await FirebaseService.betsCollection.doc(betId).update({
        'status': status.name,
        'creditsWon': creditsWon,
        'resolvedAt': DateTime.now().toIso8601String(),
      });

      // If bet won, update user's credits and stats
      if (status == BetStatus.won && creditsWon > 0) {
        final bet = await FirebaseService.betsCollection.doc(betId).get();
        final betData = bet.data() as Map<String, dynamic>;
        final userId = betData['userId'] as String;

        await FirebaseService.usersCollection.doc(userId).update({
          'credits': FieldValue.increment(creditsWon),
          'totalWins': FieldValue.increment(1),
          'totalEarnings': FieldValue.increment(creditsWon),
        });
      }
    } catch (e) {
      debugPrint('Error resolving bet: $e');
      rethrow;
    }
  }

  // Stream operations
  // Future<List<StreamModel>> getLiveStreams() async {
  //   try {
  //     final query =
  //         await FirebaseService.streamsCollection
  //             .where('isLive', isEqualTo: true)
  //             .orderBy('viewerCount', descending: true)
  //             .get();

  //     return query.docs
  //         .map(
  //           (doc) => StreamModel.fromJson(doc.data() as Map<String, dynamic>),
  //         )
  //         .toList();
  //   } catch (e) {
  //     debugPrint('Error getting live streams: $e');
  //     return [];
  //   }
  // }

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
