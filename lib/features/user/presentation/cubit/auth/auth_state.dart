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

// State that user is unauthenticated
class UnAuthenticated extends AuthState {}

// State that an auth process is currently in progress
class AuthProcessInProgress extends AuthState {}

// State that an auth process encountered an error
class AuthProcessFailure extends AuthState {}
