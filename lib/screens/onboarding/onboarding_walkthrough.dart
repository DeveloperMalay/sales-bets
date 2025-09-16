import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';

class OnboardingWalkthrough extends StatefulWidget {
  const OnboardingWalkthrough({super.key});

  @override
  State<OnboardingWalkthrough> createState() => _OnboardingWalkthroughState();
}

class _OnboardingWalkthroughState extends State<OnboardingWalkthrough> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Sales Bets!',
      subtitle: 'The revolutionary betting platform for business challenges',
      description: 'Join the excitement of business competitions where teams compete in real-world challenges and you can bet on the outcomes.',
      icon: Icons.emoji_events,
      color: AppTheme.primaryColor,
    ),
    OnboardingPage(
      title: 'No-Loss Guarantee',
      subtitle: 'Your credits never decrease!',
      description: 'Unlike traditional betting, you can only WIN credits. Your account balance never goes down - it only goes up when your team succeeds!',
      icon: Icons.shield_outlined,
      color: AppTheme.successColor,
    ),
    OnboardingPage(
      title: 'How It Works',
      subtitle: 'Simple 3-step process',
      description: '1. Choose an exciting business event\n2. Pick your favorite team\n3. Stake credits and potentially win more!',
      icon: Icons.rocket_launch,
      color: AppTheme.secondaryColor,
    ),
    OnboardingPage(
      title: 'Live Events & Streaming',
      subtitle: 'Watch the action unfold',
      description: 'Join live streams to watch teams compete in real-time. Chat with other users and cheer on your picks!',
      icon: Icons.live_tv,
      color: AppTheme.warningColor,
    ),
    OnboardingPage(
      title: 'Ready to Start?',
      subtitle: 'Your journey begins now',
      description: 'You\'ll start with 1,000 free credits. Remember - you can only gain more credits, never lose them!',
      icon: Icons.celebration,
      color: AppTheme.primaryColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _pages[_currentIndex].color.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
          ),
          
          // Page view
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),

          // Page indicators
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? _pages[_currentIndex].color
                        : Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // Bottom buttons
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                if (_currentIndex < _pages.length - 1)
                  TextButton(
                    onPressed: _skipToEnd,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),

                // Next/Get Started button
                ElevatedButton(
                  onPressed: _currentIndex == _pages.length - 1
                      ? _completeOnboarding
                      : _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pages[_currentIndex].color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    _currentIndex == _pages.length - 1 
                        ? 'Get Started' 
                        : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back button (except first page)
          if (_currentIndex > 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: IconButton(
                onPressed: _previousPage,
                icon: const Icon(Icons.arrow_back_ios),
                color: _pages[_currentIndex].color,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largeSpacing),
        child: Column(
          children: [
            const Spacer(),
            
            // Icon with animation
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: page.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: page.color.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  page.icon,
                  size: 60,
                  color: page.color,
                ),
              ),
            ),

            const SizedBox(height: AppConstants.extraLargeSpacing),

            // Title
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                page.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppConstants.mediumSpacing),

            // Subtitle
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Text(
                page.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: page.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppConstants.largeSpacing),

            // Description
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: Text(
                page.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Special highlight for no-loss guarantee
            if (page.title == 'No-Loss Guarantee')
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Container(
                  margin: const EdgeInsets.only(top: AppConstants.largeSpacing),
                  padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                    border: Border.all(
                      color: AppTheme.successColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: AppTheme.successColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '1,000 Credits → 1,500 Credits ✓',
                            style: TextStyle(
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.block,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '1,000 Credits → 800 Credits ✗',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    Navigator.of(context).pop(true); // Return true to indicate completion
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });
}