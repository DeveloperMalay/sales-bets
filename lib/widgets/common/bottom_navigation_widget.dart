import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/themes/app_theme.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _getSelectedIndex(currentLocation);

    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            activeIcon: Icon(FontAwesomeIcons.house, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            activeIcon: Icon(FontAwesomeIcons.users, size: 24),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.video),
            activeIcon: Icon(FontAwesomeIcons.video, size: 24),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            activeIcon: Icon(FontAwesomeIcons.user, size: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/teams':
        return 1;
      case '/live':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/teams');
        break;
      case 2:
        context.go('/live');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
