import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/get_single_user_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/update_user_usecase.dart';

part 'user_state.dart';

// Cubit to primary handle user data (profile data, etc)
class UserCubit extends Cubit<UserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserCubit(
      {required this.getSingleUserUseCase, required this.updateUserUseCase})
      : super(UserInitial());

  // Emits the user entity of the given uid
  Future<void> getSingleUser({required String uid}) async {
    emit(UserLoadInProgress());

    final user = await getSingleUserUseCase(uid);

    user.fold(
        (l) => emit(UserLoadFailure()), (r) => emit(UserLoadSuccess(user: r)));
  }

  // Update the user with the provided user details
  Future<void> updateUser({required UserEntity user}) async {
    final updateUserResult = await updateUserUseCase.call(user);

    // If the update was successful, emit a success state containing the updated user
    updateUserResult.fold((l) => null, (r) => emit(UserLoadSuccess(user: user)));
  }
}
