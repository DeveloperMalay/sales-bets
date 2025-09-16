import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../models/achievement/achievement_model.dart';
import '../../services/achievement_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen>
    with TickerProviderStateMixin {
  final AchievementService _achievementService = AchievementService();
  List<AchievementModel> _allAchievements = [];
  List<UserAchievementModel> _userAchievements = [];
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAchievements();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAchievements() async {
    try {
      setState(() => _isLoading = true);
      
      // For now, we'll use a placeholder user ID
      // In a real app, get this from auth service
      const userId = 'current_user_id';
      
      final achievements = await _achievementService.getAllAchievements();
      final userAchievements = await _achievementService.getUserAchievements(userId);
      
      setState(() {
        _allAchievements = achievements;
        _userAchievements = userAchievements;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading achievements: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Achievements',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unlocked'),
            Tab(text: 'Progress'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildAllAchievements(),
                _buildUnlockedAchievements(),
                _buildProgressView(),
              ],
            ),
    );
  }

  Widget _buildAllAchievements() {
    if (_allAchievements.isEmpty) {
      return const Center(
        child: Text(
          'No achievements available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      itemCount: _allAchievements.length,
      itemBuilder: (context, index) {
        final achievement = _allAchievements[index];
        final isUnlocked = _userAchievements
            .any((ua) => ua.achievementId == achievement.id);
        
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildAchievementCard(achievement, isUnlocked),
        );
      },
    );
  }

  Widget _buildUnlockedAchievements() {
    final unlockedIds = _userAchievements.map((ua) => ua.achievementId).toSet();
    final unlockedAchievements = _allAchievements
        .where((achievement) => unlockedIds.contains(achievement.id))
        .toList();

    if (unlockedAchievements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No achievements unlocked yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Start betting to earn your first achievements!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      itemCount: unlockedAchievements.length,
      itemBuilder: (context, index) {
        final achievement = unlockedAchievements[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildAchievementCard(achievement, true),
        );
      },
    );
  }

  Widget _buildProgressView() {
    return ListView(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      children: [
        _buildProgressCard(
          'Total Achievements',
          _userAchievements.length,
          _allAchievements.length,
          Icons.emoji_events,
          AppTheme.primaryColor,
        ),
        const SizedBox(height: AppConstants.mediumSpacing),
        _buildProgressCard(
          'Common Achievements',
          _getUnlockedByRarity(AchievementRarity.common),
          _getTotalByRarity(AchievementRarity.common),
          Icons.star_border,
          Colors.grey,
        ),
        const SizedBox(height: AppConstants.mediumSpacing),
        _buildProgressCard(
          'Rare Achievements',
          _getUnlockedByRarity(AchievementRarity.rare),
          _getTotalByRarity(AchievementRarity.rare),
          Icons.star_half,
          Colors.blue,
        ),
        const SizedBox(height: AppConstants.mediumSpacing),
        _buildProgressCard(
          'Epic Achievements',
          _getUnlockedByRarity(AchievementRarity.epic),
          _getTotalByRarity(AchievementRarity.epic),
          Icons.star,
          Colors.purple,
        ),
        const SizedBox(height: AppConstants.mediumSpacing),
        _buildProgressCard(
          'Legendary Achievements',
          _getUnlockedByRarity(AchievementRarity.legendary),
          _getTotalByRarity(AchievementRarity.legendary),
          Icons.stars,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildAchievementCard(AchievementModel achievement, bool isUnlocked) {
    final rarityColor = AchievementService.getRarityColor(achievement.rarity);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: isUnlocked 
            ? Border.all(color: rarityColor, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Achievement icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isUnlocked 
                  ? rarityColor.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
              border: Border.all(
                color: isUnlocked ? rarityColor : Colors.grey,
                width: 2,
              ),
            ),
            child: Icon(
              _getIconData(achievement.iconName),
              size: 30,
              color: isUnlocked ? rarityColor : Colors.grey,
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          
          // Achievement details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    if (isUnlocked)
                      Icon(
                        Icons.check_circle,
                        color: rarityColor,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnlocked ? Colors.black54 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: rarityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        achievement.rarity.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: rarityColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${achievement.rewardCredits}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    String title,
    int unlocked,
    int total,
    IconData icon,
    Color color,
  ) {
    final progress = total > 0 ? unlocked / total : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$unlocked/$total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toInt()}% Complete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

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

  int _getUnlockedByRarity(AchievementRarity rarity) {
    final rarityAchievementIds = _allAchievements
        .where((a) => a.rarity == rarity)
        .map((a) => a.id)
        .toSet();
    
    return _userAchievements
        .where((ua) => rarityAchievementIds.contains(ua.achievementId))
        .length;
  }

  int _getTotalByRarity(AchievementRarity rarity) {
    return _allAchievements.where((a) => a.rarity == rarity).length;
  }
}