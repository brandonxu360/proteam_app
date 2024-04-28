import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {

  // Attempt sign in with email and password
  Future<Either<Failure, String>> signInWithEmail(String email, String password);

  // Register with email and password
  Future<Either<Failure, String>> registerWithEmail(String email, String password);

  // Get the signed in status (valid uid = a user is signed in, null = no user is signed in)
  Future<Either<Failure, String?>> isSignedIn();

  // Sign the current user out
  Future<Either<Failure, void>> signOut();

  // Get the user ID of the current signed in user
  Future<Either<Failure, String>> getCurrentUID();

  // Create a user in the user records/database
  Future<Either<Failure, void>> createUser(UserEntity user);

  // Get the user entity (user details) of a single user using UID input
  Future<Either<Failure, UserEntity>> getSingleUser(String uid);
}