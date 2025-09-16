import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../cubits/navigation/navigation_cubit.dart';
import '../../core/themes/app_theme.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) => context.read<NavigationCubit>().changeTab(index),
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
      },
    );
  }
}