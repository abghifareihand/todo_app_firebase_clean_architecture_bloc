import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> register(String name, String email, String password);
  Future<Either<Failure, Auth>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}
