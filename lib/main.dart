import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sales_bets/screens/home/cubit/home_cubit.dart';
import 'package:sales_bets/screens/teams/cubit/teams_cubit.dart';
import 'core/themes/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'cubits/theme/theme_cubit.dart';
import 'cubits/navigation/navigation_cubit.dart';
import 'screens/onboarding/cubit/auth_bloc.dart';
import 'screens/betting/cubit/betting_bloc.dart';
import 'services/api/firestore_repository.dart';
import 'screens/onboarding/auth_wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase with secure configuration
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SalesBetsApp());
}

class SalesBetsApp extends StatelessWidget {
  const SalesBetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirestoreRepository>(
          create: (context) => FirestoreRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => NavigationCubit()),
          BlocProvider(
            create: (context) => AuthBloc()..add(AuthCheckRequested()),
          ),
          BlocProvider(
            create:
                (context) => BettingBloc(
                  repository: context.read<FirestoreRepository>(),
                ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(context.read<FirestoreRepository>()),
          ),
          BlocProvider(
            create:
                (context) => TeamsCubit(context.read<FirestoreRepository>()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              home: const AuthWrapper(),
            );
          },
        ),
      ),
    );
  }
}
