import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sales_bets/screens/profile/cubit/profile_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../onboarding/cubit/auth_bloc.dart';
import '../../models/bet/bet_model.dart';
import '../dev/dev_tools_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ProfileCubit>().loadUserProfile(authState.user.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            ],
          ),
          body:
              state.status == ProfileStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        FadeInDown(child: _buildProfileHeader(context, state)),
                        const SizedBox(height: AppConstants.largeSpacing),
                        FadeInUp(child: _buildStatsCards(context, state)),
                        const SizedBox(height: AppConstants.largeSpacing),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: _buildBettingHistory(context, state),
                        ),
                        const SizedBox(height: AppConstants.largeSpacing),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: _buildMenuItems(context),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.largeSpacing),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.extraLargeSpacing),
          bottomRight: Radius.circular(AppConstants.extraLargeSpacing),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child:
                state.user?.profileImageUrl != null
                    ? ClipOval(
                      child: Image.network(
                        state.user!.profileImageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 50,
                            color: AppTheme.primaryColor,
                          );
                        },
                      ),
                    )
                    : const Icon(
                      Icons.person,
                      size: 50,
                      color: AppTheme.primaryColor,
                    ),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Text(
            state.user?.displayName ?? 'User',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            state.user?.email ?? '',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getMemberSinceText(state),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _getMemberSinceText(ProfileState state) {
    if (state.user?.createdAt == null) return 'New Member';

    final createdAt = state.user!.createdAt!;
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return 'Member since ${months[createdAt.month - 1]} ${createdAt.year}';
  }

  Widget _buildStatsCards(BuildContext context, ProfileState state) {
    final winRate = _calculateWinRate(state);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Credits',
              _formatNumber(state.user?.credits ?? 1000),
              Icons.account_balance_wallet,
              AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: _buildStatCard(
              'Total Wins',
              '${state.user?.totalWins ?? 0}',
              Icons.emoji_events,
              AppTheme.successColor,
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: _buildStatCard(
              'Win Rate',
              '$winRate%',
              Icons.trending_up,
              AppTheme.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
    }
    return number.toString();
  }

  int _calculateWinRate(ProfileState state) {
    if (state.user == null || state.user!.totalWins == 0) return 0;

    final totalBets = state.recentBets.length;
    if (totalBets == 0) return 0;

    final wins =
        state.recentBets.where((bet) => bet.status == BetStatus.won).length;
    return ((wins / totalBets) * 100).round();
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
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
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: AppConstants.smallSpacing),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBettingHistory(BuildContext context, ProfileState state) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Bets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          if (state.recentBets.isEmpty)
            const Center(
              child: Text(
                'No bets placed yet',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          else
            ...state.recentBets.map((bet) => _buildBetHistoryItem(bet)),
        ],
      ),
    );
  }

  Widget _buildBetHistoryItem(BetModel bet) {
    final isWin = bet.status == BetStatus.won;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: (isWin ? AppTheme.successColor : Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        border: Border.all(
          color: isWin ? AppTheme.successColor : Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isWin ? Icons.check_circle : Icons.cancel,
            color: isWin ? AppTheme.successColor : Colors.grey,
            size: 24,
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Bet #${bet.id.substring(0, 8)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${_getBetStatusText(bet.status)} • ${_getTimeAgo(bet.placedAt)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isWin ? '+${bet.creditsWon}' : '0',
                style: TextStyle(
                  color: isWin ? AppTheme.successColor : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Credits',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getBetStatusText(BetStatus status) {
    switch (status) {
      case BetStatus.won:
        return 'Won';
      case BetStatus.lost:
        return 'Lost';
      case BetStatus.pending:
        return 'Pending';
    }
  }

  String _getTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return 'Unknown';

    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.errorColor,
                ),
                child: const Text('Sign Out'),
              ),
            ],
          ),
    );

    if (shouldSignOut == true && mounted) {
      context.read<AuthBloc>().add(AuthSignOutRequested());
    }
  }

  Widget _buildMenuItems(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
      ),
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
        children: [
          _buildMenuItem('Following Teams', Icons.favorite, () {}),
          _buildMenuItem('Betting History', Icons.history, () {}),
          _buildMenuItem('Notifications', Icons.notifications, () {}),
          // Add dev tools for development
          _buildMenuItem(
            'Developer Tools',
            Icons.build,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DevToolsScreen()),
            ),
          ),
          _buildMenuItem('Help & Support', Icons.help, () {}),
          _buildMenuItem('Privacy Policy', Icons.privacy_tip, () {}),
          _buildMenuItem(
            'Sign Out',
            Icons.logout,
            () => _handleSignOut(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppTheme.errorColor : AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppTheme.errorColor : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
