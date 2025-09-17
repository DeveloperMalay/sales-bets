import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import 'package:sales_bets/models/bet/bet_model.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.betWon && state.creditsWon != null) {
          _triggerWinAnimation(state.creditsWon!);
          context.read<HomeCubit>().clearAnimation();
        } else if (state.status == HomeStatus.betLost) {
          _triggerLoseAnimation();
          context.read<HomeCubit>().clearAnimation();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                // Main content
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
                
                // Confetti overlay
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: 1.57, // radians (90 degrees - downward)
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 50,
                      gravity: 0.1,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                        Colors.yellow,
                      ],
                    ),
                  ),
                ),
              ],
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

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
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
          ),
        );
      },
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

                  // Find if user has a bet on this event
                  final userBet = state.userBets.cast<BetModel?>().firstWhere(
                    (bet) => bet?.eventId == event.id,
                    orElse: () => null,
                  );
                  
                  // Debug logging
                  debugPrint('🎯 Event ${event.id} (${event.title}):');
                  debugPrint('  - Total user bets: ${state.userBets.length}');
                  debugPrint('  - User bet for this event: ${userBet?.id ?? "null"}');
                  if (userBet != null) {
                    debugPrint('  - Bet status: ${userBet.status}');
                    debugPrint('  - Bet team: ${userBet.teamId}');
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                      right: AppConstants.mediumSpacing,
                      bottom: AppConstants.smallSpacing,
                    ),
                    child: EventCard(
                      title: event.title,
                      teams: event.teamIds,
                      isLive: event.status == EventStatus.live,
                      userBet: userBet,
                      eventStatus: event.status.name,
                      eventWinnerId: event.winnerId,
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

  void _triggerWinAnimation(int creditsWon) {
    // Start confetti
    _confettiController.play();
    
    // Start scale animation for wallet card
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    // Show snackbar with win details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '🎉 You won $creditsWon credits! Congratulations! 🎉',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _triggerLoseAnimation() {
    // Show encouraging message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.sentiment_satisfied, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '💪 Better luck next time! Remember, your credits never decrease.',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
