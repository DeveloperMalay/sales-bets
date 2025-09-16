import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation/navigation_cubit.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/teams/teams_screen.dart';
import '../../screens/live_stream/live_stream_screen.dart';
import '../../screens/profile/profile_screen.dart';
import 'bottom_navigation_widget.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [
              HomeScreen(),
              TeamsScreen(),
              LiveStreamScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: const BottomNavigationWidget(),
        );
      },
    );
  }
}