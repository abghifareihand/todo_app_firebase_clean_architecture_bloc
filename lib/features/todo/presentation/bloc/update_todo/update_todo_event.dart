part of 'update_todo_bloc.dart';

abstract class UpdateTodoEvent extends Equatable {}

class UpdateTodo extends UpdateTodoEvent {
  final String id;
  final String title;
  final String description;
  final String category;

  UpdateTodo(this.id, this.title, this.description, this.category);

  @override
  List<Object> get props => [id, title, description, category];
}

class UpdateTodoStatus extends UpdateTodoEvent {
  final String id;
  final bool status;

  UpdateTodoStatus(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}
