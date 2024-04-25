import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/get_current_uid_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/is_signed_in_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isSignedInUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  // Emit authentication state
  Future<void> appStart() async {
    final isSignedIn = await isSignedInUseCase.call();
    final getUidResult = await getCurrentUidUseCase.call();

    // Get the right value
    final uid = getUidResult.fold((l) => null, (r) => r);

    // Emit authenticated if right values for isSignedIn and getUid, and isSignedIn is true
    isSignedIn.fold((l) => emit(UnAuthenticated()), (r) {
      if (uid != null && r) {
        emit(Authenticated(uid: uid));
      } else {
        // Emit Unauthenticated if left values occur or isSignedIn is false (TODO: emit error/failure states instead when a left value is encountered)
        emit(UnAuthenticated());
      }
    });
  }
}
