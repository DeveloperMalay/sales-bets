import 'package:flutter/material.dart';
import '../../services/storage/preferences_service.dart';
import '../../widgets/common/main_wrapper.dart';
import 'onboarding_walkthrough.dart';

class OnboardingWrapper extends StatefulWidget {
  const OnboardingWrapper({super.key});

  @override
  State<OnboardingWrapper> createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  bool _isLoading = true;
  bool _shouldShowOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      final hasCompletedOnboarding = await PreferencesService.isOnboardingCompleted();
      
      if (mounted) {
        setState(() {
          _shouldShowOnboarding = !hasCompletedOnboarding;
          _isLoading = false;
        });
      }
    } catch (e) {
      // If there's an error, show onboarding to be safe
      if (mounted) {
        setState(() {
          _shouldShowOnboarding = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onOnboardingCompleted() async {
    await PreferencesService.setOnboardingCompleted(true);
    await PreferencesService.setFirstTimeUser(false);
    
    if (mounted) {
      setState(() {
        _shouldShowOnboarding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_shouldShowOnboarding) {
      return OnboardingWalkthroughWithCallback(
        key: const Key('onboarding_walkthrough'),
        onCompleted: _onOnboardingCompleted,
      );
    }

    return const MainWrapper();
  }
}

// Custom OnboardingWalkthrough with callback
class OnboardingWalkthroughWithCallback extends OnboardingWalkthrough {
  final VoidCallback? onCompleted;

  const OnboardingWalkthroughWithCallback({
    super.key,
    this.onCompleted,
  });

  @override
  State<OnboardingWalkthrough> createState() => _OnboardingWalkthroughWithCallbackState();
}

class _OnboardingWalkthroughWithCallbackState extends State<OnboardingWalkthroughWithCallback> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Sales Bets!',
      subtitle: 'The revolutionary betting platform for business challenges',
      description: 'Join the excitement of business competitions where teams compete in real-world challenges and you can bet on the outcomes.',
      icon: Icons.emoji_events,
      color: const Color(0xFF6366F1),
    ),
    OnboardingPage(
      title: 'No-Loss Guarantee',
      subtitle: 'Your credits never decrease!',
      description: 'Unlike traditional betting, you can only WIN credits. Your account balance never goes down - it only goes up when your team succeeds!',
      icon: Icons.shield_outlined,
      color: const Color(0xFF10B981),
    ),
    OnboardingPage(
      title: 'How It Works',
      subtitle: 'Simple 3-step process',
      description: '1. Choose an exciting business event\n2. Pick your favorite team\n3. Stake credits and potentially win more!',
      icon: Icons.rocket_launch,
      color: const Color(0xFFF59E0B),
    ),
    OnboardingPage(
      title: 'Live Events & Streaming',
      subtitle: 'Watch the action unfold',
      description: 'Join live streams to watch teams compete in real-time. Chat with other users and cheer on your picks!',
      icon: Icons.live_tv,
      color: const Color(0xFFEF4444),
    ),
    OnboardingPage(
      title: 'Ready to Start?',
      subtitle: 'Your journey begins now',
      description: 'You\'ll start with 1,000 free credits. Remember - you can only gain more credits, never lose them!',
      icon: Icons.celebration,
      color: const Color(0xFF6366F1),
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

          // Navigation and indicators (same as original implementation)
          _buildBottomControls(),
          
          // Back button
          if (_currentIndex > 0) _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    // Same implementation as original but with proper context handling
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            
            // Icon with animation
            Container(
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

            const SizedBox(height: 48),

            // Title
            Text(
              page.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Subtitle
            Text(
              page.subtitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: page.color,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Description
            Text(
              page.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            // Special highlight for no-loss guarantee
            if (page.title == 'No-Loss Guarantee')
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.3),
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
                          color: const Color(0xFF10B981),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '1,000 Credits → 1,500 Credits ✓',
                          style: TextStyle(
                            color: const Color(0xFF10B981),
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

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // Page indicators
          Row(
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
          
          const SizedBox(height: 24),
          
          // Navigation buttons
          Row(
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
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: IconButton(
        onPressed: _previousPage,
        icon: const Icon(Icons.arrow_back_ios),
        color: _pages[_currentIndex].color,
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

  Future<void> _completeOnboarding() async {
    await PreferencesService.setOnboardingCompleted(true);
    await PreferencesService.setFirstTimeUser(false);
    
    if (widget.onCompleted != null) {
      widget.onCompleted!();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainWrapper()),
      );
    }
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