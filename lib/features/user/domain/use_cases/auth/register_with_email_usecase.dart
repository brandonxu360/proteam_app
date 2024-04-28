import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class RegisterWithEmail {
  final UserRepository repository;

  RegisterWithEmail({required this.repository});

  Future<Either<Failure, String>> call(String email, String password) async {
    return repository.registerWithEmail(email, password);
  }
}