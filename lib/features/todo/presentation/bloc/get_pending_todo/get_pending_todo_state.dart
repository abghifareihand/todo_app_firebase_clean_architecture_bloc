part of 'get_pending_todo_bloc.dart';

abstract class GetPendingTodoState extends Equatable {}

class GetPendingTodoInitial extends GetPendingTodoState {
  @override
  List<Object> get props => [];
}

class GetPendingTodoLoading extends GetPendingTodoState {
  @override
  List<Object> get props => [];
}

class GetPendingTodoError extends GetPendingTodoState {
  final String message;

  GetPendingTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class GetPendingTodoLoaded extends GetPendingTodoState {
  final List<Todo> todo;

  GetPendingTodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}
