part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, loaded, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final User? user;
  factory AuthState.initial() =>
      AuthState(status: AuthStatus.initial, errorMessage: null);

  const AuthState({this.user, required this.status, this.errorMessage});

  @override
  List<Object?> get props => [user, status, errorMessage];

  AuthState copyWith({AuthStatus? status, String? errorMessage, User? user}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
