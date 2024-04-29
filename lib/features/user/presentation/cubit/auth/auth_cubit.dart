import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/core/utils/string_conversion_helpers.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/get_current_uid_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/is_signed_in_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/register_with_email_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_in_with_email_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_out_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/create_user_usecase.dart';

part 'auth_state.dart';

// Cubit to primarily handle user authentication
class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;
  final RegisterWithEmailUseCase registerWithEmail;
  final CreateUserUseCase createUserUseCase;
  final SignInWithEmailUseCase signInWithEmailUseCase;

  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isSignedInUseCase,
      required this.signOutUseCase,
      required this.registerWithEmail,
      required this.createUserUseCase,
      required this.signInWithEmailUseCase})
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
  Future<void> registerWithEmailPassword(
      String email, String username, String password) async {
    emit(RegisterInProgress());

    // Try registering the user with the provided credentials
    final registrationResult = await registerWithEmail.call(email, password);

    registrationResult.fold((l) {
      // Registration failed (email already in use, etc)
      if (l is AuthFailure) {
        emit(RegisterFailure(feedback: convertFirebaseAuthErrorCode(l.errorCode)));
      } 
      // Unexpected techincal error - server failure, etc.
      else {
        emit(RegisterError());
      }
    }, (r) async {
      // Create the user record in the database if the user auth was successful
      await createUserUseCase
          .call(UserEntity(uid: r, username: username, email: email));
      emit(RegisterAuthenticated(uid: r));
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(SignInInProgress());

    // Try sign in with the provided credentials
    final signInResult = await signInWithEmailUseCase(email, password);

    signInResult.fold((l) {
      // Authentication failure - incorrect credentials, etc.
      if (l is AuthFailure) {
        emit(SignInFailure(feedback: convertFirebaseAuthErrorCode(l.errorCode)));
      }
      // Unexpected technical error - server failure, etc.
      else {
        emit(SignInError());
      }
    }, (r) => emit(SignInAuthenticated(uid: r)));
  }

  Future<void> signOut() async {
    final signoutResult = await signOutUseCase.call();

    // TODO: keep in mind that the users data should be removed from screens, etc.

    // Sign the user out if the signout call was successful
    signoutResult.fold(
        (l) => emit(AuthProcessError()), (r) => emit(UnAuthenticated()));
  }
}
