import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../widgets/cards/event_card.dart';
import '../../widgets/cards/trending_team_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: _buildHeader(context),
              ),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInLeft(
                child: _buildWalletCard(context),
              ),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInUp(
                child: _buildSectionTitle('Live Events'),
              ),
              const SizedBox(height: AppConstants.mediumSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _buildEventsList(),
              ),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _buildSectionTitle('Trending Teams'),
              ),
              const SizedBox(height: AppConstants.mediumSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _buildTrendingTeams(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              AppConstants.appTagline,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(AppConstants.smallSpacing),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          ),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Credits',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppConstants.smallSpacing),
          const Text(
            '1,000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallSpacing),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppTheme.successColor, size: 16),
              const SizedBox(width: 4),
              Text(
                '+50 today',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEventsList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppConstants.mediumSpacing),
            child: EventCard(
              title: 'Championship Final ${index + 1}',
              teams: ['Team Alpha', 'Team Beta'],
              isLive: index < 2,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingTeams() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppConstants.mediumSpacing),
            child: TrendingTeamCard(
              teamName: 'Team ${String.fromCharCode(65 + index)}',
              followers: '${(index + 1) * 123}K',
              isFollowing: index % 2 == 0,
            ),
          );
        },
      ),
    );
  }
}