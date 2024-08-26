part of 'get_date_todo_bloc.dart';

abstract class GetDateTodoEvent extends Equatable {}

class GetDateTodo extends GetDateTodoEvent {
  final DateTime date;

  GetDateTodo(this.date);
  @override
  List<Object> get props => [date];
}
