import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_bets/screens/home/cubit/home_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../widgets/cards/event_card.dart';
import '../../widgets/cards/trending_team_card.dart';
import '../../models/event/event_model.dart';
import '../../models/team/team_model.dart';

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
                            FadeInLeft(child: _buildWalletCard(context, state)),
                            const SizedBox(height: AppConstants.largeSpacing),
                            FadeInUp(
                              child: _buildSectionTitle(
                                'Live & Upcoming Events',
                              ),
                            ),
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

  Widget _buildWalletCard(BuildContext context, HomeState state) {
    final formattedCredits = _formatNumber(state.userCredits);
    final todayEarnings = state.todayEarnings;
    final isPositive = todayEarnings >= 0;

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
          Text(
            formattedCredits,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallSpacing),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                todayEarnings == 0
                    ? 'No activity today'
                    : '${isPositive ? '+' : ''}${_formatNumber(todayEarnings)} today',
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

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
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
      child:
          state.events.isEmpty
              ? Text('No events available at the moment.')
              : ListView.builder(
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
                          context.pushNamed('betting', extra: event);
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
      child:
          teams.isEmpty
              ? Text('No trending teams available.')
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: AppConstants.mediumSpacing,
                    ),
                    child: TrendingTeamCard(
                      teamName: team.name,
                      followers:
                          '${(team.followers / 1000).toStringAsFixed(1)}K',
                      isFollowing: false,
                    ),
                  );
                },
              ),
    );
  }
}
