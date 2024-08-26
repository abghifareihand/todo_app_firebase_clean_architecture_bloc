import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepositoryImpl({
    required this.todoRemoteDatasource,
  });
  @override
  Future<Either<Failure, Todo>> addTodo(String title, String description, String category, DateTime date) async {
    try {
      final response = await todoRemoteDatasource.addTodo(title, description, category, date);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTodo(String id) async {
    try {
      final response = await todoRemoteDatasource.deleteTodo(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<Todo>> getCompletedTodo() {
    return todoRemoteDatasource.getCompletedTodo();
  }

  @override
  Stream<List<Todo>> getPendingTodo() {
    return todoRemoteDatasource.getPendingTodo();
  }

  @override
  Stream<List<Todo>> getDateTodo(DateTime date) {
    return todoRemoteDatasource.getDateTodo(date);
  }

  @override
  Future<Either<Failure, String>> updateTodo(String id, String title, String description, String category) async {
    try {
      final response = await todoRemoteDatasource.updateTodo(id, title, description, category);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateTodoStatus(String id, bool status) async {
    try {
      final response = await todoRemoteDatasource.updateTodoStatus(id, status);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
