import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class SignInWithEmail {
  final UserRepository repository;

  SignInWithEmail({required this.repository});

  Future<Either<Failure, void>> call(String email, String password) async {
    return repository.signInWithEmail(email, password);
  }
}