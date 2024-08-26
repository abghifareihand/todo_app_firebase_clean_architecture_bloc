part of 'get_date_todo_bloc.dart';

abstract class GetDateTodoState extends Equatable {}

class GetDateTodoInitial extends GetDateTodoState {
  @override
  List<Object> get props => [];
}

class GetDateTodoLoading extends GetDateTodoState {
  @override
  List<Object> get props => [];
}

class GetDateTodoError extends GetDateTodoState {
  final String message;

  GetDateTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class GetDateTodoLoaded extends GetDateTodoState {
  final List<Todo> todo;

  GetDateTodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}
