import 'package:dartz/dartz.dart';
import '../repositories/todo_repository.dart';
import '../../../../core/error/failure.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;
  DeleteTodoUsecase(this.todoRepository);

  Future<Either<Failure, String>> execute(String id) {
    return todoRepository.deleteTodo(id);
  }
}
