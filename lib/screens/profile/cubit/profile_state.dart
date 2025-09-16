// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;
  final UserModel? user;
  final List<BetModel> recentBets;

  const ProfileState({
    required this.status,
    required this.errorMessage,
    required this.user,
    required this.recentBets,
  });

  factory ProfileState.initial() => ProfileState(
    status: ProfileStatus.initial,
    errorMessage: null,
    user: null,
    recentBets: [],
  );

  @override
  List<Object?> get props => [status, errorMessage, user, recentBets];

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    UserModel? user,
    List<BetModel>? recentBets,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      recentBets: recentBets ?? this.recentBets,
    );
  }
}
