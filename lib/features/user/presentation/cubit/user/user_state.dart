part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

// Loading state of retrieving a user
class UserLoadInProgress extends UserState {}

// Success state of retrieving a user - carries the user entity in the state
class UserLoadSuccess extends UserState {
  final UserEntity user;

  const UserLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

// Failure state of retrieving a user - something went wrong when retrieving the user
class UserLoadFailure extends UserState {}
