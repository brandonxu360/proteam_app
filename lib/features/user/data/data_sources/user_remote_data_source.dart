import 'package:proteam_app/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  // Attempt sign in with email and password
  Future<String> signInWithEmail(String email, String password);

  // Register with email and password, return the uid when successful
  Future<String> registerWithEmail(String email, String password);

  // Get the signed in status (uid = a user is signed in, null = no user is signed in)
  Future<String?> isSignedIn();

  // Sign the current user out
  Future<void> signOut();

  // Get the user ID of the current signed in user
  Future<String> getCurrentUID();

  // Create a user in the user records/database
  Future<void> createUser(UserEntity user);

  // Get the user entity (user details) of a single user using UID input
  Future<UserEntity> getSingleUser(String uid);

  // Update an existing user with new user entity details
  Future<void> updateUser(UserEntity user);
}
