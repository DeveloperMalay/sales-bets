import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../screens/onboarding/login_screen.dart';
import '../../screens/onboarding/signup_screen.dart';
import '../../screens/onboarding/onboarding_wrapper.dart';
import '../../widgets/common/main_wrapper.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/teams/teams_screen.dart';
import '../../screens/live_stream/live_stream_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/betting/betting_screen.dart';
import '../../screens/stream/stream_viewer_screen.dart';
import '../../screens/dev/dev_tools_screen.dart';
import '../../screens/achievements/achievements_screen.dart';
import '../../models/event/event_model.dart';
import '../../models/stream/stream_model.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    redirect: _redirect,
    routes: [
      // Auth routes
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingWrapper(),
      ),
      
      // Main app with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainWrapper(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/teams',
            name: 'teams',
            builder: (context, state) => const TeamsScreen(),
          ),
          GoRoute(
            path: '/live',
            name: 'live',
            builder: (context, state) => const LiveStreamScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Full screen routes
      GoRoute(
        path: '/betting',
        name: 'betting',
        builder: (context, state) {
          final event = state.extra as EventModel;
          return BettingScreen(event: event);
        },
      ),
      GoRoute(
        path: '/stream',
        name: 'stream',
        builder: (context, state) {
          final stream = state.extra as StreamModel;
          return StreamViewerScreen(stream: stream);
        },
      ),
      GoRoute(
        path: '/achievements',
        name: 'achievements',
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/dev-tools',
        name: 'dev-tools',
        builder: (context, state) => const DevToolsScreen(),
      ),
    ],
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;
    
    // If user is not logged in and trying to access protected routes
    if (!isLoggedIn && !_isPublicRoute(state.matchedLocation)) {
      return '/auth';
    }
    
    // If user is logged in and on auth routes, redirect to home
    if (isLoggedIn && _isAuthRoute(state.matchedLocation)) {
      return '/home';
    }
    
    return null;
  }

  static bool _isPublicRoute(String route) {
    return route.startsWith('/auth') || route.startsWith('/signup');
  }

  static bool _isAuthRoute(String route) {
    return route.startsWith('/auth') || 
           route.startsWith('/signup') || 
           route.startsWith('/onboarding');
  }
}