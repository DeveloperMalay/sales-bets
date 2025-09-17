import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sales_bets/screens/auth/cubit/auth_cubit.dart';
import 'package:sales_bets/screens/home/cubit/home_cubit.dart';
import 'package:sales_bets/screens/profile/cubit/profile_cubit.dart';
import 'package:sales_bets/screens/teams/cubit/teams_cubit.dart';
import 'core/themes/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/routing/app_router.dart';
import 'cubits/theme/theme_cubit.dart';
import 'cubits/navigation/navigation_cubit.dart';
import 'screens/betting/cubit/betting_cubit.dart';
import 'services/api/firestore_repository.dart';
import 'services/push_notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase with secure configuration
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up Firebase Messaging background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(
            create: (context) => BettingCubit(context.read<FirestoreRepository>()),
          ),
          BlocProvider(
            create: (context) => HomeCubit(context.read<FirestoreRepository>()),
          ),
          BlocProvider(
            create:
                (context) => TeamsCubit(context.read<FirestoreRepository>()),
          ),
          BlocProvider(
            create:
                (context) => ProfileCubit(context.read<FirestoreRepository>()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
