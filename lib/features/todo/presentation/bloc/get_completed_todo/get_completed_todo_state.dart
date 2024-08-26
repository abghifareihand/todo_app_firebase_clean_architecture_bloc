part of 'get_completed_todo_bloc.dart';

abstract class GetCompletedTodoState extends Equatable {}

class GetCompletedTodoInitial extends GetCompletedTodoState {
  @override
  List<Object> get props => [];
}

class GetCompletedTodoLoading extends GetCompletedTodoState {
  @override
  List<Object> get props => [];
}

class GetCompletedTodoError extends GetCompletedTodoState {
  final String message;

  GetCompletedTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class GetCompletedTodoLoaded extends GetCompletedTodoState {
  final List<Todo> todo;

  GetCompletedTodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}
