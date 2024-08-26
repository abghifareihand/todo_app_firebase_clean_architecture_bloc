import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetCompletedTodoUsecase {
  final TodoRepository todoRepository;
  GetCompletedTodoUsecase(this.todoRepository);

  Stream<List<Todo>> execute() {
    return todoRepository.getCompletedTodo();
  }
}
