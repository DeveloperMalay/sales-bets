import 'package:flutter/material.dart';
import '../../models/achievement/achievement_model.dart';
import '../../services/achievement_service.dart';

class AchievementBadge extends StatelessWidget {
  final AchievementModel achievement;
  final bool isUnlocked;
  final double size;
  final VoidCallback? onTap;

  const AchievementBadge({
    super.key,
    required this.achievement,
    required this.isUnlocked,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rarityColor = AchievementService.getRarityColor(achievement.rarity);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isUnlocked 
              ? rarityColor.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(size / 4),
          border: Border.all(
            color: isUnlocked ? rarityColor : Colors.grey,
            width: 2,
          ),
          boxShadow: isUnlocked 
              ? [
                  BoxShadow(
                    color: rarityColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Main icon
            Center(
              child: Icon(
                _getIconData(achievement.iconName),
                size: size * 0.5,
                color: isUnlocked ? rarityColor : Colors.grey,
              ),
            ),
            
            // Rarity indicator
            if (isUnlocked)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: size * 0.25,
                  height: size * 0.25,
                  decoration: BoxDecoration(
                    color: rarityColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Icon(
                    _getRarityIcon(achievement.rarity),
                    size: size * 0.15,
                    color: Colors.white,
                  ),
                ),
              ),
            
            // Lock overlay for locked achievements
            if (!isUnlocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(size / 4),
                  ),
                  child: Icon(
                    Icons.lock,
                    size: size * 0.3,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
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

  IconData _getRarityIcon(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return Icons.circle;
      case AchievementRarity.rare:
        return Icons.star_border;
      case AchievementRarity.epic:
        return Icons.star;
      case AchievementRarity.legendary:
        return Icons.stars;
    }
  }
}

class AchievementTooltip extends StatelessWidget {
  final AchievementModel achievement;
  final bool isUnlocked;
  final Widget child;

  const AchievementTooltip({
    super.key,
    required this.achievement,
    required this.isUnlocked,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${achievement.title}\n${achievement.description}\n'
               '${isUnlocked ? "Unlocked!" : "Locked"}\n'
               'Reward: ${achievement.rewardCredits} credits',
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      child: child,
    );
  }
}

class RecentAchievementsBanner extends StatelessWidget {
  final List<AchievementModel> recentAchievements;
  final VoidCallback? onViewAll;

  const RecentAchievementsBanner({
    super.key,
    required this.recentAchievements,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recentAchievements.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.1),
            Colors.blue.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events,
                color: Colors.purple,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Recent Achievements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const Spacer(),
              if (onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: const Text('View All'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recentAchievements.map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AchievementTooltip(
                    achievement: achievement,
                    isUnlocked: true,
                    child: AchievementBadge(
                      achievement: achievement,
                      isUnlocked: true,
                      size: 56,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}