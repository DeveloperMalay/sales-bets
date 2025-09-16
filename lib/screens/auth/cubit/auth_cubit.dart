import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/user/user_model.dart';
import 'package:sales_bets/services/api/firebase_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseService.auth;

  AuthCubit() : super(AuthState.initial());

  Future<void> signInAnonymously() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      emit(state.copyWith(status: AuthStatus.loaded, user: user));
    } on FirebaseAuthException catch (e) {
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

        emit(state.copyWith(status: AuthStatus.loaded, user: credential.user));
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
        emit(state.copyWith(status: AuthStatus.loaded, user: credential.user));
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
