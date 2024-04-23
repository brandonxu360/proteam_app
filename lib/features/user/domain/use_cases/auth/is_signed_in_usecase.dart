import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class IsSignedInUseCase {
  final UserRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignedIn();
  }
}