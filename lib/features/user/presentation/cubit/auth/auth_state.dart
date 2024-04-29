part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// State that user is authenticated
class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});

  @override
  List<Object> get props => [uid];
}

class RegisterAuthenticated extends Authenticated {
  const RegisterAuthenticated({required super.uid});
}

class SignInAuthenticated extends Authenticated {
  const SignInAuthenticated({required super.uid});
}

// State that user is unauthenticated
class UnAuthenticated extends AuthState {}

// State that an auth process is currently in progress
class AuthProcessInProgress extends AuthState {}

class RegisterInProgress extends AuthProcessInProgress {}

class SignInInProgress extends AuthProcessInProgress {}

// State the an auth process failed to authenticate the user
class AuthProcessFailure extends AuthState {
  // Attempt feedback (ie. invalid credentials, email already in use, etc.)
  final String feedback;

  const AuthProcessFailure({required this.feedback});

  @override
  List<Object> get props => [feedback];
}

class RegisterFailure extends AuthProcessFailure {
  const RegisterFailure({required super.feedback});
}

class SignInFailure extends AuthProcessFailure {
  const SignInFailure({required super.feedback});
}

// State that an auth process encountered an error (ie. server failure, firebase backend failure)
class AuthProcessError extends AuthState {}

class RegisterError extends AuthProcessError {}

class SignInError extends AuthProcessError {}

class SignOutError extends AuthProcessError {}
