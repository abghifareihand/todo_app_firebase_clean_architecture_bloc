import 'package:dartz/dartz.dart';

import '../entities/auth.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase(this.authRepository);

  Future<Either<Failure, Auth>> execute(String name, String email, String password) {
    return authRepository.register(name, email, password);
  }
}
