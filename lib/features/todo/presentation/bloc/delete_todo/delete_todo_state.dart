part of 'delete_todo_bloc.dart';

abstract class DeleteTodoState extends Equatable {}

class DeleteTodoInitial extends DeleteTodoState {
  @override
  List<Object> get props => [];
}

class DeleteTodoLoading extends DeleteTodoState {
  @override
  List<Object> get props => [];
}

class DeleteTodoError extends DeleteTodoState {
  final String message;

  DeleteTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteTodoLoaded extends DeleteTodoState {
  final String message;

  DeleteTodoLoaded(this.message);
  @override
  List<Object> get props => [message];
}
