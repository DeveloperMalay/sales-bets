import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/real_time_bet_service.dart';
import 'bottom_navigation_widget.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final RealTimeBetService _betService = RealTimeBetService();

  @override
  void initState() {
    super.initState();
    _initializeBetService();
  }

  void _initializeBetService() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _betService.initialize(context, user.uid);
      // Initialize achievements in Firestore (one-time setup)
      _betService.initializeAchievements();
    }
  }

  @override
  void dispose() {
    _betService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
