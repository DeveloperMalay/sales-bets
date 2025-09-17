import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/user/user_model.dart';
import 'package:sales_bets/services/api/firebase_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseService.auth;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit() : super(AuthState.initial()) {
    // Listen to auth state changes
    _initializeAuthListener();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }

  void _initializeAuthListener() {
    // Listen to auth state changes
    _authStateSubscription = _auth.authStateChanges().listen((User? user) {
      debugPrint('🔍 Auth state changed: ${user?.uid ?? "null"} (${user?.email ?? "no email"})');
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.loaded, user: user));
      } else {
        emit(AuthState.initial());
      }
    });
    
    // Also check current state immediately
    final currentUser = _auth.currentUser;
    debugPrint('🔍 Current user on init: ${currentUser?.uid ?? "null"} (${currentUser?.email ?? "no email"})');
    if (currentUser != null) {
      emit(state.copyWith(status: AuthStatus.loaded, user: currentUser));
    }
  }

  void refreshAuthState() {
    final currentUser = _auth.currentUser;
    debugPrint('🔍 Manual refresh - current user: ${currentUser?.uid ?? "null"} (${currentUser?.email ?? "no email"})');
    if (currentUser != null) {
      emit(state.copyWith(status: AuthStatus.loaded, user: currentUser));
    } else {
      emit(AuthState.initial());
    }
  }

  void debugAuthState() {
    debugPrint('🔍 Current AuthCubit state:');
    debugPrint('  - Status: ${state.status}');
    debugPrint('  - User: ${state.user?.uid ?? "null"} (${state.user?.email ?? "no email"})');
    debugPrint('  - Error: ${state.errorMessage ?? "none"}');
    debugPrint('🔍 Firebase Auth current user:');
    final firebaseUser = _auth.currentUser;
    debugPrint('  - UID: ${firebaseUser?.uid ?? "null"}');
    debugPrint('  - Email: ${firebaseUser?.email ?? "no email"}');
    debugPrint('  - Is Anonymous: ${firebaseUser?.isAnonymous ?? "unknown"}');
  }

  Future<void> signInAnonymously() async {
    try {
      debugPrint('🔑 Starting anonymous sign in...');
      emit(state.copyWith(status: AuthStatus.loading));
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      debugPrint('✅ Anonymous sign in successful: ${user?.uid}');
      // Note: The auth state listener will handle the state update
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Anonymous sign in failed: ${e.message}');
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.message));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(fullName);

        // Create user document in Firestore
        await _createUserDocument(credential.user!, fullName);
        
        debugPrint('✅ Sign up successful: ${credential.user!.uid}');
        // Note: The auth state listener will handle the state update
      }
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: "An unexpected error occurred",
          status: AuthStatus.error,
        ),
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        debugPrint('✅ Email sign in successful: ${credential.user!.uid}');
        // Note: The auth state listener will handle the state update
      }
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: "An unexpected error occurred",
          status: AuthStatus.error,
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(AuthState.initial());
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Error signing out. Please try again.',
        ),
      );
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

    await FirebaseService.usersCollection.doc(user.uid).set(userModel.toJson());
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
