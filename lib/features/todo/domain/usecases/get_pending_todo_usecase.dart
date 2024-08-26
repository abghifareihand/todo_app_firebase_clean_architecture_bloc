import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetPendingTodoUsecase {
  final TodoRepository todoRepository;
  GetPendingTodoUsecase(this.todoRepository);

  Stream<List<Todo>> execute() {
    return todoRepository.getPendingTodo();
  }
}
