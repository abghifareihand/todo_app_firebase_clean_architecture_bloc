import 'package:dartz/dartz.dart';

import '../entities/auth.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase(this.authRepository);

  Future<Either<Failure, Auth>> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}
