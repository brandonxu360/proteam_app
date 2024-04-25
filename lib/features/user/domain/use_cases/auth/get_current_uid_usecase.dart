import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class GetCurrentUidUseCase {
  final UserRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<Either<Failure, String>> call() async {
    return repository.getCurrentUID();
  }
}