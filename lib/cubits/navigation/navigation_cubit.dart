import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void goToHome() => changeTab(0);
  void goToTeams() => changeTab(1);
  void goToLive() => changeTab(2);
  void goToProfile() => changeTab(3);
}