import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/get_single_user_usecase.dart';

part 'user_state.dart';

// Cubit to primary handle user data (profile data, etc)
class UserCubit extends Cubit<UserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  UserCubit({required this.getSingleUserUseCase}) : super(UserInitial());

  // Emits the user entity of the given uid
  Future<void> getSingleUser({required String uid}) async {
    emit(UserLoadInProgress());

    final user = await getSingleUserUseCase(uid);

    user.fold((l) => emit(UserLoadFailure()), (r) => emit(UserLoadSuccess(user: r)));
  }
}
