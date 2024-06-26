import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  
  @override
  List<Object> get props => [];
}

// Generic server failure - indicating a failure relating to the remote data source
class ServerFailure extends Failure {}

// Authentication failures
class AuthFailure extends Failure {
  final String errorCode;

  AuthFailure({required this.errorCode});
}