import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetDateTodoUsecase {
  final TodoRepository todoRepository;
  GetDateTodoUsecase(this.todoRepository);

  Stream<List<Todo>> execute(DateTime date) {
    return todoRepository.getDateTodo(date);
  }
}
