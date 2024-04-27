import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/get_current_uid_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/is_signed_in_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/register_with_email_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_out_usecase.dart';

part 'auth_state.dart';

// Cubit to primarily handle user authentication
class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;
  final RegisterWithEmail registerWithEmail;

  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isSignedInUseCase,
      required this.signOutUseCase,
      required this.registerWithEmail})
      : super(AuthInitial());

  // Emit authentication state (is a user signed in or not)
  Future<void> appStart() async {
    // Determine if a user is signed in
    final uid = await isSignedInUseCase.call();

    // Emit authenticated state if valid uid was returned
    // TODO: emit a failure/error state rather than simply unauthenticated if a failure was returned (left val)
    uid.fold((l) => emit(UnAuthenticated()), (r) {
      if (r == null) {
        emit(UnAuthenticated());
      } else {
        emit(Authenticated(uid: r));
      }
    });
  }

  // Register a new user with email and password
  Future<void> registerWithEmailPassword(String email, String password) async {
    emit(AuthProcessInProgress());

    // Try registering the user with the provided credentials
    final registrationResult = await registerWithEmail.call(email, password);

    // TODO: emit a failure/error state rather than simply unathenticated if a failure was returned
    registrationResult.fold((l) {
      emit(AuthProcessFailure());
    }, (r) {
      emit(Authenticated(uid: r));
    });
  }

  Future<void> signOut() async {
    final signoutResult = await signOutUseCase.call();

    // TODO: keep in mind that the users data should be removed from screens, etc.

    // Sign the user out if the signout call was successful
    signoutResult.fold(
        (l) => emit(AuthProcessFailure()), (r) => emit(UnAuthenticated()));
  }
}
