import 'package:dartz/dartz.dart';
import '../repositories/todo_repository.dart';
import '../../../../core/error/failure.dart';

class UpdateTodoUsecase {
  final TodoRepository todoRepository;
  UpdateTodoUsecase(this.todoRepository);

  Future<Either<Failure, String>> execute(String id, String title, String description, String category) {
    return todoRepository.updateTodo(id, title, description, category);
  }
}
