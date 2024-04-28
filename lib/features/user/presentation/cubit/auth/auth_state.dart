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

class RegisterUnAuthenticated extends UnAuthenticated {
  final String registerErrorMessage;

  RegisterUnAuthenticated({required this.registerErrorMessage});
}

class SignInUnAuthenticated extends UnAuthenticated {
  final String signInErrorMessage;

  SignInUnAuthenticated({required this.signInErrorMessage});
}

// State that an auth process is currently in progress
class AuthProcessInProgress extends AuthState {}

class RegisterInProgress extends AuthProcessInProgress {}
class SignInInProgress extends AuthProcessInProgress {}

// State that an auth process encountered an error
class AuthProcessFailure extends AuthState {}

class RegisterFailure extends AuthProcessFailure {}

class SignInFailure extends AuthProcessFailure {}
