import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/screens/auth/cubit/auth_cubit.dart';
import '../onboarding/onboarding_wrapper.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == AuthStatus.loaded && state.user != null) {
          return const OnboardingWrapper();
        }

        return const LoginScreen();
      },
    );
  }
}
