import 'package:equatable/equatable.dart';

// Represents a user of the app
class UserEntity extends Equatable {

  final String uid;
  final String username;
  final String email;
  final String? pfpUrl;

  const UserEntity({required this.uid, required this.username, required this.email, this.pfpUrl});

  @override
  List<Object?> get props => [uid, username, email, pfpUrl];
}