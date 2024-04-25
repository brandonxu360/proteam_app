import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, void>> createUser(UserEntity user) async {
    try {
      // Call the user remote data source to create a document for the input user
      await userRemoteDataSource.createUser(user);

      // Return a right value of null to signify success
      return const Right(null);
    } catch (e) {
      // Return a left ServerFailure to signify failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUID() async {
    try {
      // Call the user remote data source to get the current uid
      final currentUID = await userRemoteDataSource.getCurrentUID();

      return Right(currentUID);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getSingleUser(String uid) async {
    try {
      // Call the user remote data source to get the user
      final user = await userRemoteDataSource.getSingleUser(uid);

      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      // Call the user remote data source to get the sign in status
      final isSignedIn = await userRemoteDataSource.isSignedIn();

      return Right(isSignedIn);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmail(
      String email, String password) async {
    try {
      // Call the user remote data source to attempt sign in
      await userRemoteDataSource.signInWithEmail(email, password);

      // Return a right void to signify successful completion
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      // Return a right AuthFailure to signify an auth failure (ie. incorrect credentials)
      return Left(AuthFailure(errorCode: e.code));
    } catch (e) {
      // Return a right ServerFailure to signify unexpected behavior from firebase auth
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      // Call the user remote data source to attempt to sign the current user out
      await userRemoteDataSource.signOut();

      // Return a right null value to signify success
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> registerWithEmail(
      String email, String username, String password) async {
    try {
      // Register the user with firebase
      await userRemoteDataSource.registerWithEmail(email, password);

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      // Return a right AuthFailure to signify an auth failure (ie. email already in use)
      return Left(AuthFailure(errorCode: e.code));
    } catch (e) {
      // Return a right ServerFailure to signify unexpected behavior from firebase auth
      return Left(ServerFailure());
    }
  }
}
