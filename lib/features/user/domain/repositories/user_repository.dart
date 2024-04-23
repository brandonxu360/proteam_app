

import 'package:proteam_app/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  
  // Attempt sign in with email and password
  Future<void> signInWithEmail(String email, String password);

  // Get the signed in status (true = a user is signed in, false = no user is signed in)
  Future<bool> isSignedIn();

  // Sign the current user out
  Future<void> signOut();

  // Get the user ID of the current signed in user
  Future<String> getCurrentUID();

  // Create a user in the user records/database
  Future<void> createUser(UserEntity user);

  // Get the user entity (user details) of a single user using UID input
  Stream<List<UserEntity>> getSingleUser(String uid);
}