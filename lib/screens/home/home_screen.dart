import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/screens/home/cubit/home_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../widgets/cards/event_card.dart';
import '../../widgets/cards/trending_team_card.dart';
import '../../models/event/event_model.dart';
import '../../models/team/team_model.dart';
import '../../screens/betting/betting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child:
                state.status == HomeStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                      onRefresh: () async {
                        await context.read<HomeCubit>().loadHomeData();
                      },
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(
                          AppConstants.mediumSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInDown(child: _buildHeader(context)),
                            const SizedBox(height: AppConstants.largeSpacing),
                            FadeInLeft(child: _buildWalletCard(context)),
                            const SizedBox(height: AppConstants.largeSpacing),
                            FadeInUp(child: _buildSectionTitle('Live Events')),
                            const SizedBox(height: AppConstants.mediumSpacing),
                            FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: _buildEventsList(state: state),
                            ),
                            const SizedBox(height: AppConstants.largeSpacing),
                            FadeInUp(
                              delay: const Duration(milliseconds: 400),
                              child: _buildSectionTitle('Trending Teams'),
                            ),
                            const SizedBox(height: AppConstants.mediumSpacing),
                            FadeInUp(
                              delay: const Duration(milliseconds: 600),
                              child: _buildTrendingTeams(
                                teams: state.trendingTeams,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        );
      },
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
          child: const Icon(Icons.notifications, color: Colors.white),
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
            style: TextStyle(color: Colors.white70, fontSize: 14),
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
              const Icon(Icons.trending_up, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                '+50 today',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white),
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
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildEventsList({required HomeState state}) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.events.length,
        itemBuilder: (context, index) {
          final event = state.events[index];

          return Padding(
            padding: const EdgeInsets.only(
              right: AppConstants.mediumSpacing,
              bottom: AppConstants.smallSpacing,
            ),
            child: EventCard(
              title: event.title,
              teams: event.teamIds,
              isLive: event.status == EventStatus.live,
              onTap: () async {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BettingScreen(event: event),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingTeams({required List<TeamModel> teams}) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return Padding(
            padding: const EdgeInsets.only(right: AppConstants.mediumSpacing),
            child: TrendingTeamCard(
              teamName: team.name,
              followers: '${(team.followers / 1000).toStringAsFixed(1)}K',
              isFollowing: false,
            ),
          );
        },
      ),
    );
  }
}
