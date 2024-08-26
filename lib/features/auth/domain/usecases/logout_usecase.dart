import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;
  LogoutUsecase(this.authRepository);

  Future<Either<Failure, String>> execute() {
    return authRepository.logout();
  }
}
