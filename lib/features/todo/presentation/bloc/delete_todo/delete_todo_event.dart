part of 'delete_todo_bloc.dart';

abstract class DeleteTodoEvent extends Equatable {}

class DeleteTodo extends DeleteTodoEvent {
  final String id;

  DeleteTodo(this.id);

  @override
  List<Object> get props => [];
}
