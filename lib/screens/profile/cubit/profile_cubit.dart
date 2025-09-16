import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/bet/bet_model.dart';
import 'package:sales_bets/models/user/user_model.dart';
import 'package:sales_bets/services/api/firestore_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirestoreRepository _repository;

  ProfileCubit(this._repository) : super(ProfileState.initial());

  Future<void> loadUserProfile(String userId) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final user = await _repository.getUser(userId);
      final recentBets = await _repository.getUserBets(userId);
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          user: user,
          recentBets: recentBets,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'Error loading profile: $e',
        ),
      );
    }
  }
}
