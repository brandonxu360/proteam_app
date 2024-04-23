import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return repository.signOut();
  }
}