import 'package:dartz/dartz.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth.dart';
import '../../../../core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });
  @override
  Future<Either<Failure, Auth>> register(String name, String email, String password) async {
    try {
      final response = await authRemoteDatasource.register(name, email, password);
      await authLocalDatasource.saveAuthData(response); // save to local
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Auth>> login(String email, String password) async {
    try {
      final response = await authRemoteDatasource.login(email, password);
      await authLocalDatasource.saveAuthData(response); // save to local
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await authLocalDatasource.removeAuthData(); // remove from local
      final response = await authRemoteDatasource.logout();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
