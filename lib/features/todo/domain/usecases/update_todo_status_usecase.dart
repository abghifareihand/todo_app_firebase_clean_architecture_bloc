import 'package:dartz/dartz.dart';
import '../repositories/todo_repository.dart';
import '../../../../core/error/failure.dart';

class UpdateTodoStatusUsecase {
  final TodoRepository todoRepository;
  UpdateTodoStatusUsecase(this.todoRepository);

  Future<Either<Failure, String>> execute(String id, bool status) {
    return todoRepository.updateTodoStatus(id, status);
  }
}
