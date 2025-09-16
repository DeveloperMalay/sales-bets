import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/themes/app_theme.dart';
import '../../core/constants/app_constants.dart';

class WinCelebrationDialog extends StatefulWidget {
  final int creditsWon;

  const WinCelebrationDialog({
    super.key,
    required this.creditsWon,
  });

  @override
  State<WinCelebrationDialog> createState() => _WinCelebrationDialogState();
}

class _WinCelebrationDialogState extends State<WinCelebrationDialog>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Start animations
    _confettiController.forward();
    _bounceController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.largeSpacing),
        decoration: BoxDecoration(
          gradient: AppTheme.winGradient,
          borderRadius: BorderRadius.circular(AppConstants.largeRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Confetti Animation
            SizedBox(
              height: 60,
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, child) {
                  return Stack(
                    children: List.generate(15, (index) {
                      final offset = Offset(
                        (index % 5) * 60.0 - 120,
                        -20 + (_confettiController.value * 40),
                      );
                      return Positioned(
                        left: MediaQuery.of(context).size.width / 2 + offset.dx,
                        top: offset.dy,
                        child: Transform.rotate(
                          angle: _confettiController.value * 4,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: [
                                Colors.yellow,
                                Colors.orange,
                                Colors.red,
                                Colors.pink,
                                Colors.purple
                              ][index % 5],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            // Trophy Icon with Bounce Animation
            AnimatedBuilder(
              animation: _bounceController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_bounceController.value * 0.1),
                  child: ZoomIn(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        size: 40,
                        color: Color(0xFFFFD700), // Gold color
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppConstants.largeSpacing),

            // Win Message
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: const Text(
                '🎉 Congratulations! 🎉',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // Credits Won
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeSpacing,
                  vertical: AppConstants.mediumSpacing,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                ),
                child: Column(
                  children: [
                    const Text(
                      'You Won',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+${widget.creditsWon} Credits',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // No-Loss Reminder
            FadeInUp(
              delay: const Duration(milliseconds: 700),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.smallSpacing),
                    const Text(
                      'Remember: You never lose credits!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.largeSpacing),

            // Close Button
            FadeInUp(
              delay: const Duration(milliseconds: 900),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                    ),
                  ),
                  child: const Text(
                    'Awesome!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}