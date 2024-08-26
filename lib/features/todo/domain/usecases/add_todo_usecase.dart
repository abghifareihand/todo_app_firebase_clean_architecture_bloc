import 'package:dartz/dartz.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../../../core/error/failure.dart';

class AddTodoUsecase {
  final TodoRepository todoRepository;
  AddTodoUsecase(this.todoRepository);

  Future<Either<Failure, Todo>> execute(String title, String description, String category, DateTime date) {
    return todoRepository.addTodo(title, description, category, date);
  }
}
