import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class IsSignedInUseCase {
  final UserRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<Either<Failure, String?>> call() async {
    return repository.isSignedIn();
  }
}