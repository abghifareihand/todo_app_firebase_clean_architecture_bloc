import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> addTodo(String title, String description, String category, DateTime date);
  Future<Either<Failure, String>> updateTodo(String id, String title, String description, String category);
  Future<Either<Failure, String>> deleteTodo(String id);
  Future<Either<Failure, String>> updateTodoStatus(String id, bool status);

  Stream<List<Todo>> getCompletedTodo();
  Stream<List<Todo>> getPendingTodo();
  Stream<List<Todo>> getDateTodo(DateTime date);
}
