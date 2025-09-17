import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:confetti/confetti.dart';
import '../../models/bet/bet_model.dart';
import '../../models/user/user_model.dart';
import '../../core/themes/app_theme.dart';
import '../../services/api/firestore_repository.dart';

class BetResultsScreen extends StatefulWidget {
  const BetResultsScreen({super.key});

  @override
  State<BetResultsScreen> createState() => _BetResultsScreenState();
}

class _BetResultsScreenState extends State<BetResultsScreen>
    with TickerProviderStateMixin {
  final FirestoreRepository _repository = FirestoreRepository();
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  
  String? userId;
  UserModel? currentUser;
  List<BetModel> userBets = [];
  Map<String, BetStatus> previousBetStatuses = {};

  @override
  void initState() {
    super.initState();
    
    // Initialize confetti controller
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    
    // Initialize scale animation controller
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      _loadInitialData();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    if (userId == null) return;
    
    try {
      final user = await _repository.getUser(userId!);
      final bets = await _repository.getUserBets(userId!);
      
      setState(() {
        currentUser = user;
        userBets = bets;
        // Initialize previous statuses
        for (final bet in bets) {
          previousBetStatuses[bet.id] = bet.status;
        }
      });
    } catch (e) {
      debugPrint('Error loading initial data: $e');
    }
  }

  void _handleBetStatusChange(BetModel newBet) {
    final previousStatus = previousBetStatuses[newBet.id];
    final newStatus = newBet.status;

    // Only trigger animations if status actually changed
    if (previousStatus != newStatus) {
      switch (newStatus) {
        case BetStatus.won:
          _triggerWinAnimation(newBet);
          break;
        case BetStatus.lost:
          _triggerLoseAnimation();
          break;
        case BetStatus.pending:
          // No specific animation for pending
          break;
      }
      
      // Update the stored status
      previousBetStatuses[newBet.id] = newStatus;
    }
  }

  void _triggerWinAnimation(BetModel winningBet) {
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
                'You won ${winningBet.creditsWon} credits! 🎉',
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
                'Better luck next time! Your credits never decrease 💪',
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

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to view bet results'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Bet Results'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Wallet section
              _buildWalletCard(),
              
              // Bets list
              Expanded(
                child: _buildBetsList(),
              ),
            ],
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
    );
  }

  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: StreamBuilder<DocumentSnapshot>(
        stream: userId != null 
            ? FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots()
            : null,
        builder: (context, snapshot) {
          UserModel? user;
          
          if (snapshot.hasData && snapshot.data!.exists) {
            try {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              user = UserModel.fromJson({...data, 'id': snapshot.data!.id});
            } catch (e) {
              debugPrint('Error parsing user data: $e');
            }
          }

          return AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Card(
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Wallet',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${user?.credits ?? 1000} Credits',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Total Earned: +${user?.totalEarnings ?? 0}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBetsList() {
    if (userId == null) {
      return const Center(child: Text('User not logged in'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bets')
          .where('userId', isEqualTo: userId)
          .orderBy('placedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_esports, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No bets yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Place your first bet to see results here!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        final bets = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return BetModel.fromJson({...data, 'id': doc.id});
        }).toList();

        // Check for status changes and trigger animations
        for (final bet in bets) {
          _handleBetStatusChange(bet);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bets.length,
          itemBuilder: (context, index) {
            final bet = bets[index];
            return _buildBetCard(bet);
          },
        );
      },
    );
  }

  Widget _buildBetCard(BetModel bet) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIcon(bet.status),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event: ${bet.eventId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Team: ${bet.teamId}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(bet.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Staked:', style: TextStyle(fontSize: 12)),
                    Text(
                      '${bet.creditsStaked} credits',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (bet.status == BetStatus.won)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Won:', style: TextStyle(fontSize: 12)),
                      Text(
                        '+${bet.creditsWon} credits',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                if (bet.status == BetStatus.pending)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status:', style: TextStyle(fontSize: 12)),
                      Text(
                        'Waiting for result...',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BetStatus status) {
    switch (status) {
      case BetStatus.won:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.celebration, color: Colors.white, size: 20),
        );
      case BetStatus.lost:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.sentiment_satisfied, color: Colors.white, size: 20),
        );
      case BetStatus.pending:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.schedule, color: Colors.white, size: 20),
        );
    }
  }

  Widget _buildStatusChip(BetStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case BetStatus.won:
        color = Colors.green;
        text = 'WON';
        break;
      case BetStatus.lost:
        color = Colors.orange;
        text = 'LOST';
        break;
      case BetStatus.pending:
        color = Colors.blue;
        text = 'PENDING';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}