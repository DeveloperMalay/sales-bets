import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:confetti/confetti.dart';
import 'package:sales_bets/screens/auth/cubit/auth_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../models/event/event_model.dart';
import '../../models/team/team_model.dart';
import '../../models/bet/bet_model.dart';
import 'cubit/betting_cubit.dart';

class BettingScreen extends StatefulWidget {
  final EventModel event;

  const BettingScreen({super.key, required this.event});

  @override
  State<BettingScreen> createState() => _BettingScreenState();
}

class _BettingScreenState extends State<BettingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _customAmountController = TextEditingController();
  late ConfettiController _confettiController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // Refresh auth state to ensure we have current user
    context.read<AuthCubit>().refreshAuthState();

    final authState = context.read<AuthCubit>().state;
    final userId = authState.user?.uid ?? '';
    debugPrint('🎯 Loading betting data for event: ${widget.event.id}');
    debugPrint('🎯 Event status on load: ${widget.event.status}');
    debugPrint('🎯 Event winner: ${widget.event.winnerId}');
    context.read<BettingCubit>().loadBettingData(widget.event.id, userId);
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Your Bet'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<BettingCubit, BettingState>(
        listener: (context, state) {
          if (state.status == BettingStatus.betPlaced) {
            _showBetPlacedDialog(context);
          } else if (state.status == BettingStatus.betWon &&
              state.creditsWon != null) {
            _triggerWinAnimation(state.creditsWon!);
            context.read<BettingCubit>().clearWinCelebration();
          } else if (state.status == BettingStatus.betLost) {
            _triggerLoseAnimation();
            context.read<BettingCubit>().clearWinCelebration();
          } else if (state.status == BettingStatus.error &&
              state.errorMessage != null) {
            _showErrorDialog(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.status == BettingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Main content
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(child: _buildEventCard(state)),
                    const SizedBox(height: AppConstants.largeSpacing),
                    if (state.existingBet != null)
                      FadeInLeft(child: _buildExistingBetCard(state))
                    else ...[
                      FadeInLeft(child: _buildNoLossExplanation()),
                      const SizedBox(height: AppConstants.largeSpacing),
                      FadeInUp(child: _buildTeamSelection(state)),
                      const SizedBox(height: AppConstants.largeSpacing),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: _buildBetAmountSelection(state),
                      ),
                      const SizedBox(height: AppConstants.largeSpacing),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _buildPotentialWinnings(state),
                      ),
                    ],
                    const SizedBox(height: AppConstants.extraLargeSpacing),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: _buildPlaceBetButton(state),
                    ),
                  ],
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
          );
        },
      ),
    );
  }

  Widget _buildEventCard(BettingState state) {
    final event = state.event ?? widget.event;
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      event.status == EventStatus.live
                          ? AppTheme.errorColor
                          : AppTheme.warningColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event.status == EventStatus.live ? 'LIVE' : 'UPCOMING',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Text(
            event.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallSpacing),
          Text(
            event.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Row(
            children: [
              const Icon(Icons.schedule, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                _formatDate(widget.event.startTime),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExistingBetCard(BettingState state) {
    if (state.existingBet == null) return const SizedBox.shrink();

    final existingBet = state.existingBet!;
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: Border.all(color: AppTheme.primaryColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You Already Have a Bet!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Staked: ${existingBet.creditsStaked} credits • Status: ${existingBet.status.toString().split('.').last.toUpperCase()}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                if (existingBet.status == BetStatus.won)
                  Text(
                    'Winnings: +${existingBet.creditsWon} credits',
                    style: const TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoLossExplanation() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: Border.all(color: AppTheme.successColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.successColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'No-Loss Guarantee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your credits never decrease! You can only win more credits if your team succeeds.',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSelection(BettingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Team',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppConstants.mediumSpacing),
        ...state.teams.map((team) => _buildTeamOption(team, state)),
      ],
    );
  }

  Widget _buildTeamOption(TeamModel team, BettingState state) {
    final isSelected = state.selectedTeamId == team.id;
    final event = state.event ?? widget.event;
    final odds = event.odds[team.id] ?? 2.0;

    return AnimatedScale(
      scale: isSelected ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () => context.read<BettingCubit>().selectTeam(team.id),
        child: Container(
          margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppTheme.primaryColor.withOpacity(0.1)
                    : Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
            border: Border.all(
              color:
                  isSelected
                      ? AppTheme.primaryColor
                      : Colors.grey.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(
                    AppConstants.mediumRadius,
                  ),
                ),
                child: const Icon(Icons.group, color: Colors.white),
              ),
              const SizedBox(width: AppConstants.mediumSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${team.wins} wins • ${team.followers} followers',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${odds.toStringAsFixed(1)}x',
                      style: const TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBetAmountSelection(BettingState state) {
    final presetAmounts = [25, 50, 100, 250, 500];

    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stake Amount (Credits)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Wrap(
            spacing: AppConstants.smallSpacing,
            runSpacing: AppConstants.smallSpacing,
            children:
                presetAmounts.map((amount) {
                  final isSelected = state.creditsToStake == amount;
                  return AnimatedScale(
                    scale: isSelected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap:
                          () => context.read<BettingCubit>().updateStakeAmount(
                            amount,
                          ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppTheme.primaryColor
                                    : Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          '$amount',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight:
                                isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          TextField(
            controller: _customAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Custom Amount',
              hintText:
                  'Enter amount between ${AppConstants.minBetAmount} - ${AppConstants.maxBetAmount}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
              ),
              prefixIcon: const Icon(Icons.account_balance_wallet),
            ),
            onChanged: (value) {
              final amount = int.tryParse(value);
              if (amount != null) {
                context.read<BettingCubit>().updateStakeAmount(amount);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPotentialWinnings(BettingState state) {
    if (state.selectedTeamId == null) {
      return const SizedBox.shrink();
    }

    final bettingCubit = context.read<BettingCubit>();
    final team = bettingCubit.getTeamById(state.selectedTeamId!);
    if (team == null) return const SizedBox.shrink();

    final potentialWin = bettingCubit.calculatePotentialWinnings();
    final netProfit = bettingCubit.calculateNetProfit();

    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        gradient: AppTheme.winGradient,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Potential Profit (No-Loss)',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '+$netProfit Credits',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Stake: ${state.creditsToStake} → Total: $potentialWin',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.trending_up, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceBetButton(BettingState state) {
    final canPlaceBet =
        state.existingBet == null && // Can't place bet if one already exists
        state.selectedTeamId != null &&
        state.creditsToStake >= AppConstants.minBetAmount &&
        state.creditsToStake <= AppConstants.maxBetAmount;

    final isLoading = state.status == BettingStatus.placingBet;

    // Debug information
    debugPrint('🔍 Button state check:');
    debugPrint(
      '  - existingBet: ${state.existingBet == null ? "null (good)" : "exists (blocking)"}',
    );
    debugPrint(
      '  - selectedTeamId: ${state.selectedTeamId ?? "null (blocking)"}',
    );
    debugPrint(
      '  - creditsToStake: ${state.creditsToStake} (min: ${AppConstants.minBetAmount}, max: ${AppConstants.maxBetAmount})',
    );
    debugPrint('  - canPlaceBet: $canPlaceBet');
    debugPrint('  - isLoading: $isLoading');

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canPlaceBet && !isLoading ? () => _placeBet(state) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          ),
        ),
        child:
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                  state.existingBet != null
                      ? 'Bet Already Placed'
                      : 'Place No-Loss Bet',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }

  void _placeBet(BettingState state) {
    debugPrint('🎯 Place bet button clicked!');
    debugPrint('🎯 Selected team: ${state.selectedTeamId}');
    debugPrint('🎯 Credits to stake: ${state.creditsToStake}');
    debugPrint('🎯 Event: ${state.event?.title}');

    // Debug auth state
    context.read<AuthCubit>().debugAuthState();

    final authState = context.read<AuthCubit>().state;

    // Try getting user from Firebase Auth directly as fallback
    final firebaseUser = FirebaseAuth.instance.currentUser;

    String? userId;
    if (authState.user != null) {
      userId = authState.user!.uid;
      debugPrint('✅ Using AuthCubit user: $userId');
    } else if (firebaseUser != null) {
      userId = firebaseUser.uid;
      debugPrint('✅ Using Firebase Auth user: $userId');
    } else {
      debugPrint('❌ No authenticated user found in either source');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to place a bet'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<BettingCubit>().placeBet(userId);
  }

  void _showBetPlacedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text('Bet Placed!'),
              ],
            ),
            content: const Text(
              'Your no-loss bet has been placed successfully! You\'ll be notified when the event concludes.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _triggerWinAnimation(int creditsWon) {
    // Start confetti
    _confettiController.play();

    // Start scale animation
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

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} days from now';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours from now';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes from now';
    } else {
      return 'Starting now';
    }
  }
}
