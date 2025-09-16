import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import '../../models/user/user_model.dart';
import '../../services/api/firebase_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseService.auth;

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthUserChanged>(_onUserChanged);

    // Listen to auth state changes
    _auth.authStateChanges().listen((user) {
      add(AuthUserChanged(user));
    });
  }

  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      
      if (credential.user != null) {
        emit(AuthAuthenticated(credential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  void _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      
      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(event.displayName);
        
        // Create user document in Firestore
        await _createUserDocument(credential.user!, event.displayName);
        
        emit(AuthAuthenticated(credential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  void _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Failed to sign out'));
    }
  }

  void _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _createUserDocument(User user, String displayName) async {
    final userModel = UserModel(
      id: user.uid,
      email: user.email!,
      displayName: displayName,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    await FirebaseService.usersCollection
        .doc(user.uid)
        .set(userModel.toJson());
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'The password provided is too weak';
      case 'invalid-email':
        return 'The email address is not valid';
      default:
        return 'An error occurred. Please try again';
    }
  }
}