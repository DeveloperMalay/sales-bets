import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sales_bets/screens/home/cubit/home_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../models/event/event_model.dart';
import '../../models/team/team_model.dart';
import '../onboarding/cubit/auth_bloc.dart';
import 'cubit/betting_bloc.dart';
import '../../widgets/animations/win_celebration.dart';

class BettingScreen extends StatefulWidget {
  final EventModel event;

  const BettingScreen({super.key, required this.event});

  @override
  State<BettingScreen> createState() => _BettingScreenState();
}

class _BettingScreenState extends State<BettingScreen> {
  String? selectedTeamId;
  int creditsToStake = 50;
  final TextEditingController _customAmountController = TextEditingController();

  @override
  void initState() {
    context.read<HomeCubit>().getTeamsForEvent(widget.event);
    super.initState();
  }

  @override
  void dispose() {
    _customAmountController.dispose();
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
      body: BlocListener<BettingBloc, BettingState>(
        listener: (context, state) {
          if (state is BetPlaced) {
            _showBetPlacedDialog(context);
          } else if (state is BetWon) {
            _showWinCelebration(context, state.creditsWon);
          } else if (state is BettingError) {
            _showErrorDialog(context, state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(child: _buildEventCard()),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInLeft(child: _buildNoLossExplanation()),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInUp(child: _buildTeamSelection()),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _buildBetAmountSelection(),
              ),
              const SizedBox(height: AppConstants.largeSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _buildPotentialWinnings(),
              ),
              const SizedBox(height: AppConstants.extraLargeSpacing),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _buildPlaceBetButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
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
                      widget.event.status == EventStatus.live
                          ? AppTheme.errorColor
                          : AppTheme.warningColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.event.status == EventStatus.live ? 'LIVE' : 'UPCOMING',
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
            widget.event.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallSpacing),
          Text(
            widget.event.description,
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

  Widget _buildTeamSelection() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.status == HomeStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : FadeIn(
              delay: const Duration(milliseconds: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Team',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  ...state.eventSpecificTeams.map(
                    (team) => _buildTeamOption(team),
                  ),
                ],
              ),
            );
      },
    );
  }

  Widget _buildTeamOption(TeamModel team) {
    final isSelected = selectedTeamId == team.id;
    final odds = widget.event.odds[team.id] ?? 2.0;

    return GestureDetector(
      onTap: () => setState(() => selectedTeamId = team.id),
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
                borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
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
    );
  }

  Widget _buildBetAmountSelection() {
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
                  final isSelected = creditsToStake == amount;
                  return GestureDetector(
                    onTap: () => setState(() => creditsToStake = amount),
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
                              isSelected ? FontWeight.w600 : FontWeight.normal,
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
                setState(() => creditsToStake = amount);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPotentialWinnings() {
    if (selectedTeamId == null) {
      return const SizedBox.shrink();
    }
    final state = context.read<HomeCubit>().state;
    final team = state.eventSpecificTeams.firstWhere(
      (t) => t.id == selectedTeamId,
    );
    final odds = widget.event.odds[team.id] ?? 2.0;
    final potentialWin = (creditsToStake * odds).round();

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
                'Potential Winnings',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '+$potentialWin Credits',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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

  Widget _buildPlaceBetButton() {
    final canPlaceBet =
        selectedTeamId != null &&
        creditsToStake >= AppConstants.minBetAmount &&
        creditsToStake <= AppConstants.maxBetAmount;

    return BlocBuilder<BettingBloc, BettingState>(
      builder: (context, state) {
        final isLoading = state is BettingLoading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: canPlaceBet && !isLoading ? _placeBet : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
              ),
            ),
            child:
                isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      'Place No-Loss Bet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
          ),
        );
      },
    );
  }

  void _placeBet() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    if (selectedTeamId != null) {
      final state = context.read<HomeCubit>().state;
      final team = state.eventSpecificTeams.firstWhere(
        (t) => t.id == selectedTeamId,
      );
      final odds = widget.event.odds[team.id] ?? 2.0;

      context.read<BettingBloc>().add(
        PlaceBetRequested(
          userId: authState.user.uid,
          eventId: widget.event.id,
          teamId: selectedTeamId!,
          creditsStaked: creditsToStake,
          odds: odds,
        ),
      );
    }
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

  void _showWinCelebration(BuildContext context, int creditsWon) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WinCelebrationDialog(creditsWon: creditsWon),
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
