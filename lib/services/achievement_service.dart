import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/achievement/achievement_model.dart';
import '../models/user/user_model.dart';
import '../models/bet/bet_model.dart';
import 'api/firebase_service.dart';
import 'notification_service.dart';

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();
  factory AchievementService() => _instance;
  AchievementService._internal();

  // Pre-defined achievements
  static final List<AchievementModel> _predefinedAchievements = [
    // Betting achievements
    AchievementModel(
      id: 'first_bet',
      title: 'First Steps',
      description: 'Place your very first bet',
      iconName: 'rocket_launch',
      type: AchievementType.firstBet,
      rarity: AchievementRarity.common,
      requiredValue: 1,
      rewardCredits: 100,
    ),
    AchievementModel(
      id: 'win_streak_3',
      title: 'Hot Streak',
      description: 'Win 3 bets in a row',
      iconName: 'local_fire_department',
      type: AchievementType.winStreak,
      rarity: AchievementRarity.rare,
      requiredValue: 3,
      rewardCredits: 300,
    ),
    AchievementModel(
      id: 'win_streak_5',
      title: 'Unstoppable',
      description: 'Win 5 bets in a row',
      iconName: 'whatshot',
      type: AchievementType.winStreak,
      rarity: AchievementRarity.epic,
      requiredValue: 5,
      rewardCredits: 750,
    ),
    AchievementModel(
      id: 'big_winner_1000',
      title: 'Big Winner',
      description: 'Win 1,000+ credits in a single bet',
      iconName: 'attach_money',
      type: AchievementType.bigWinner,
      rarity: AchievementRarity.rare,
      requiredValue: 1000,
      rewardCredits: 500,
    ),
    AchievementModel(
      id: 'high_roller_5000',
      title: 'High Roller',
      description: 'Stake 5,000+ credits in a single bet',
      iconName: 'casino',
      type: AchievementType.highRoller,
      rarity: AchievementRarity.epic,
      requiredValue: 5000,
      rewardCredits: 1000,
    ),
    
    // Milestone achievements
    AchievementModel(
      id: 'earnings_10k',
      title: 'Entrepreneur',
      description: 'Earn 10,000 total credits',
      iconName: 'trending_up',
      type: AchievementType.earningsLegend,
      rarity: AchievementRarity.rare,
      requiredValue: 10000,
      rewardCredits: 1000,
    ),
    AchievementModel(
      id: 'earnings_50k',
      title: 'Business Mogul',
      description: 'Earn 50,000 total credits',
      iconName: 'account_balance',
      type: AchievementType.earningsLegend,
      rarity: AchievementRarity.epic,
      requiredValue: 50000,
      rewardCredits: 2500,
    ),
    AchievementModel(
      id: 'veteran_50_bets',
      title: 'Betting Veteran',
      description: 'Place 50 total bets',
      iconName: 'military_tech',
      type: AchievementType.bettingVeteran,
      rarity: AchievementRarity.rare,
      requiredValue: 50,
      rewardCredits: 750,
    ),
    AchievementModel(
      id: 'lucky_7',
      title: 'Lucky Seven',
      description: 'Win exactly 7 bets',
      iconName: 'stars',
      type: AchievementType.luckyNumber,
      rarity: AchievementRarity.epic,
      requiredValue: 7,
      rewardCredits: 777,
    ),
    
    // Special achievements
    AchievementModel(
      id: 'perfect_predictor',
      title: 'Perfect Predictor',
      description: 'Win your first 10 bets without any losses',
      iconName: 'psychology',
      type: AchievementType.perfectPredictor,
      rarity: AchievementRarity.legendary,
      requiredValue: 10,
      rewardCredits: 5000,
    ),
  ];

  // Initialize achievements in Firestore
  Future<void> initializeAchievements() async {
    try {
      final batch = FirebaseService.firestore.batch();
      
      for (final achievement in _predefinedAchievements) {
        final docRef = FirebaseService.firestore
            .collection('achievements')
            .doc(achievement.id);
        
        batch.set(docRef, achievement.toJson(), SetOptions(merge: true));
      }
      
      await batch.commit();
      debugPrint('Initialized ${_predefinedAchievements.length} achievements');
    } catch (e) {
      debugPrint('Error initializing achievements: $e');
    }
  }

  // Get all achievements
  Future<List<AchievementModel>> getAllAchievements() async {
    try {
      final query = await FirebaseService.firestore
          .collection('achievements')
          .get();
      
      return query.docs
          .map((doc) => AchievementModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      debugPrint('Error getting achievements: $e');
      return [];
    }
  }

  // Get user's unlocked achievements
  Future<List<UserAchievementModel>> getUserAchievements(String userId) async {
    try {
      final query = await FirebaseService.firestore
          .collection('user_achievements')
          .where('userId', isEqualTo: userId)
          .get();
      
      return query.docs
          .map((doc) => UserAchievementModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      debugPrint('Error getting user achievements: $e');
      return [];
    }
  }

  // Check and unlock achievements based on user action
  Future<List<AchievementModel>> checkAchievements(
    String userId,
    UserModel user,
    List<BetModel> userBets, {
    BetModel? latestBet,
    BuildContext? context,
  }) async {
    final unlockedAchievements = <AchievementModel>[];
    
    try {
      // Get existing user achievements
      final existingAchievements = await getUserAchievements(userId);
      final existingIds = existingAchievements.map((a) => a.achievementId).toSet();
      
      // Check each achievement type
      for (final achievement in _predefinedAchievements) {
        if (existingIds.contains(achievement.id) && !achievement.isRepeatable) {
          continue; // Already unlocked
        }
        
        bool shouldUnlock = false;
        
        switch (achievement.type) {
          case AchievementType.firstBet:
            shouldUnlock = userBets.isNotEmpty;
            break;
            
          case AchievementType.winStreak:
            shouldUnlock = _checkWinStreak(userBets, achievement.requiredValue);
            break;
            
          case AchievementType.bigWinner:
            shouldUnlock = latestBet != null && 
                latestBet.status == BetStatus.won && 
                latestBet.creditsWon >= achievement.requiredValue;
            break;
            
          case AchievementType.highRoller:
            shouldUnlock = latestBet != null && 
                latestBet.creditsStaked >= achievement.requiredValue;
            break;
            
          case AchievementType.earningsLegend:
            shouldUnlock = user.totalEarnings >= achievement.requiredValue;
            break;
            
          case AchievementType.bettingVeteran:
            shouldUnlock = userBets.length >= achievement.requiredValue;
            break;
            
          case AchievementType.luckyNumber:
            shouldUnlock = user.totalWins == achievement.requiredValue;
            break;
            
          case AchievementType.perfectPredictor:
            shouldUnlock = _checkPerfectPredictor(userBets, achievement.requiredValue);
            break;
            
          default:
            break;
        }
        
        if (shouldUnlock) {
          await _unlockAchievement(userId, achievement);
          unlockedAchievements.add(achievement);
          
          // Show notification if context is available
          if (context != null) {
            NotificationService.showAchievementNotification(
              context,
              achievement.title,
              achievement.description,
              icon: _getIconData(achievement.iconName),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error checking achievements: $e');
    }
    
    return unlockedAchievements;
  }

  // Check win streak
  bool _checkWinStreak(List<BetModel> bets, int requiredStreak) {
    if (bets.length < requiredStreak) return false;
    
    // Sort bets by placed date (most recent first)
    final sortedBets = List<BetModel>.from(bets);
    sortedBets.sort((a, b) {
      if (a.placedAt == null && b.placedAt == null) return 0;
      if (a.placedAt == null) return 1;
      if (b.placedAt == null) return -1;
      return b.placedAt!.compareTo(a.placedAt!);
    });
    
    // Check for consecutive wins from the most recent bets
    int consecutiveWins = 0;
    for (final bet in sortedBets) {
      if (bet.status == BetStatus.won) {
        consecutiveWins++;
        if (consecutiveWins >= requiredStreak) return true;
      } else if (bet.status == BetStatus.lost) {
        break; // Streak broken
      }
      // Pending bets don't break the streak but don't count either
    }
    
    return false;
  }

  // Check perfect predictor (first N bets all won)
  bool _checkPerfectPredictor(List<BetModel> bets, int requiredCount) {
    final resolvedBets = bets.where((bet) => 
        bet.status == BetStatus.won || bet.status == BetStatus.lost).toList();
    
    if (resolvedBets.length < requiredCount) return false;
    
    // Sort by placed date (oldest first)
    resolvedBets.sort((a, b) {
      if (a.placedAt == null && b.placedAt == null) return 0;
      if (a.placedAt == null) return 1;
      if (b.placedAt == null) return -1;
      return a.placedAt!.compareTo(b.placedAt!);
    });
    
    // Check if first N bets are all wins
    for (int i = 0; i < requiredCount; i++) {
      if (resolvedBets[i].status != BetStatus.won) {
        return false;
      }
    }
    
    return true;
  }

  // Unlock achievement
  Future<void> _unlockAchievement(String userId, AchievementModel achievement) async {
    try {
      final userAchievement = UserAchievementModel(
        id: '', // Will be set by Firestore
        userId: userId,
        achievementId: achievement.id,
        unlockedAt: DateTime.now(),
      );
      
      await FirebaseService.firestore
          .collection('user_achievements')
          .add(userAchievement.toJson());
      
      // Award credits to user
      if (achievement.rewardCredits > 0) {
        await FirebaseService.usersCollection.doc(userId).update({
          'credits': FieldValue.increment(achievement.rewardCredits),
        });
      }
      
      debugPrint('Unlocked achievement: ${achievement.title} for user: $userId');
    } catch (e) {
      debugPrint('Error unlocking achievement: $e');
    }
  }

  // Get icon data from string
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'rocket_launch': return Icons.rocket_launch;
      case 'local_fire_department': return Icons.local_fire_department;
      case 'whatshot': return Icons.whatshot;
      case 'attach_money': return Icons.attach_money;
      case 'casino': return Icons.casino;
      case 'trending_up': return Icons.trending_up;
      case 'account_balance': return Icons.account_balance;
      case 'military_tech': return Icons.military_tech;
      case 'stars': return Icons.stars;
      case 'psychology': return Icons.psychology;
      default: return Icons.emoji_events;
    }
  }

  // Get rarity color
  static Color getRarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return Colors.grey;
      case AchievementRarity.rare:
        return Colors.blue;
      case AchievementRarity.epic:
        return Colors.purple;
      case AchievementRarity.legendary:
        return Colors.orange;
    }
  }

  // Mark achievement as viewed
  Future<void> markAsViewed(String userAchievementId) async {
    try {
      await FirebaseService.firestore
          .collection('user_achievements')
          .doc(userAchievementId)
          .update({'isViewed': true});
    } catch (e) {
      debugPrint('Error marking achievement as viewed: $e');
    }
  }
}