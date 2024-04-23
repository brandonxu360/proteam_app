import 'package:equatable/equatable.dart';

// Represents a user of the app
class UserEntity extends Equatable {

  final String? uid;
  final String? username;
  final String? email;
  final String? pfpUrl;

  const UserEntity({this.uid, this.username, this.email, this.pfpUrl});

  @override
  List<Object?> get props => [uid, username, email, pfpUrl];
}