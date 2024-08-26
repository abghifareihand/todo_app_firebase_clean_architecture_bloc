part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {}

class AddTodo extends AddTodoEvent {
  final String title;
  final String description;
  final String category;
  final DateTime dateTime;

  AddTodo(this.title, this.description, this.category, this.dateTime);

  @override
  List<Object> get props => [title, description, category, dateTime];
}
