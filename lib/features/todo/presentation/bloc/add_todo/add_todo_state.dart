part of 'add_todo_bloc.dart';

abstract class AddTodoState extends Equatable {}

class AddTodoInitial extends AddTodoState {
  @override
  List<Object> get props => [];
}

class AddTodoLoading extends AddTodoState {
  @override
  List<Object> get props => [];
}

class AddTodoError extends AddTodoState {
  final String message;

  AddTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class AddTodoLoaded extends AddTodoState {
  final Todo todo;

  AddTodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}
