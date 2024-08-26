part of 'update_todo_bloc.dart';

sealed class UpdateTodoState extends Equatable {}

class UpdateTodoInitial extends UpdateTodoState {
  @override
  List<Object> get props => [];
}

class UpdateTodoLoading extends UpdateTodoState {
  @override
  List<Object> get props => [];
}

class UpdateTodoError extends UpdateTodoState {
  final String message;

  UpdateTodoError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateTodoLoaded extends UpdateTodoState {
  final String message;

  UpdateTodoLoaded(this.message);
  @override
  List<Object> get props => [message];
}
