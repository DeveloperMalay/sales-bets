import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'seed_data.dart';

class DataSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Seeds all data (teams, events, and streams) to Firestore
  Future<void> seedAllData({bool forceReseed = false}) async {
    try {
      debugPrint('🌱 Starting data seeding...');

      // Check if data already exists
      if (!forceReseed) {
        final teamsSnapshot =
            await _firestore.collection('teams').limit(1).get();
        if (teamsSnapshot.docs.isNotEmpty) {
          debugPrint(
            '📊 Data already exists. Use forceReseed: true to override.',
          );
          return;
        }
      }

      // Seed teams first
      await seedTeams();

      // Seed events
      await seedEvents();

      // Seed streams
      await seedStreams();

      debugPrint('✅ Data seeding completed successfully!');
      debugPrint('📈 Seeded ${SeedData.teams.length} teams');
      debugPrint('🎯 Seeded ${SeedData.events.length} events');
      debugPrint('📺 Seeded ${SeedData.streams.length} streams');
    } catch (e) {
      debugPrint('❌ Error seeding data: $e');
      rethrow;
    }
  }

  /// Seeds team data to Firestore
  Future<void> seedTeams() async {
    debugPrint('👥 Seeding teams...');

    final batch = _firestore.batch();

    for (final team in SeedData.teams) {
      final docRef = _firestore.collection('teams').doc(team.id);
      batch.set(docRef, team.toJson());
    }

    await batch.commit();
    debugPrint('✅ Teams seeded successfully');
  }

  /// Seeds event data to Firestore
  Future<void> seedEvents() async {
    debugPrint('🎯 Seeding events...');

    final batch = _firestore.batch();

    for (final event in SeedData.events) {
      final docRef = _firestore.collection('events').doc(event.id);
      batch.set(docRef, event.toJson());
    }

    await batch.commit();
    debugPrint('✅ Events seeded successfully');
  }

  /// Seeds stream data to Firestore
  Future<void> seedStreams() async {
    debugPrint('📺 Seeding streams...');

    final batch = _firestore.batch();

    for (final stream in SeedData.streams) {
      final docRef = _firestore.collection('streams').doc(stream.id);
      batch.set(docRef, stream.toJson());
    }

    await batch.commit();
    debugPrint('✅ Streams seeded successfully');
  }

  /// Clears all seeded data from Firestore
  Future<void> clearAllData() async {
    debugPrint('🗑️ Clearing all data...');

    try {
      // Clear teams
      await _clearCollection('teams');

      // Clear events
      await _clearCollection('events');

      // Clear streams
      await _clearCollection('streams');

      debugPrint('✅ All data cleared successfully');
    } catch (e) {
      debugPrint('❌ Error clearing data: $e');
      rethrow;
    }
  }

  /// Helper method to clear a collection
  Future<void> _clearCollection(String collectionName) async {
    final collection = _firestore.collection(collectionName);
    final snapshots = await collection.get();

    final batch = _firestore.batch();
    for (final doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    debugPrint('🗑️ Cleared $collectionName collection');
  }

  /// Seeds additional sample bets for testing
  Future<void> seedSampleBets({required String userId}) async {
    debugPrint('🎲 Seeding sample bets for user: $userId');

    try {
      final sampleBets = _generateSampleBets(userId);

      final batch = _firestore.batch();
      for (final bet in sampleBets) {
        final docRef = _firestore.collection('bets').doc();
        batch.set(docRef, bet.toJson());
      }

      await batch.commit();
      debugPrint('✅ Sample bets seeded successfully');
    } catch (e) {
      debugPrint('❌ Error seeding sample bets: $e');
      rethrow;
    }
  }

  /// Generate sample betting data
  List<dynamic> _generateSampleBets(String userId) {
    // This would return a list of BetModel objects
    // For now, returning empty list since we'd need to import BetModel
    return [];
  }

  /// Check if data exists in Firestore
  Future<bool> dataExists() async {
    try {
      final teamsSnapshot = await _firestore.collection('teams').limit(1).get();
      return teamsSnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('❌ Error checking if data exists: $e');
      return false;
    }
  }

  /// Get data statistics
  Future<Map<String, int>> getDataStats() async {
    try {
      final teamsCount =
          (await _firestore.collection('teams').get()).docs.length;
      final eventsCount =
          (await _firestore.collection('events').get()).docs.length;
      final streamsCount =
          (await _firestore.collection('streams').get()).docs.length;
      final usersCount =
          (await _firestore.collection('users').get()).docs.length;
      final betsCount = (await _firestore.collection('bets').get()).docs.length;

      return {
        'teams': teamsCount,
        'events': eventsCount,
        'streams': streamsCount,
        'users': usersCount,
        'bets': betsCount,
      };
    } catch (e) {
      debugPrint('❌ Error getting data stats: $e');
      return {};
    }
  }
}
