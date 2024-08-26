import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/add_todo_usecase.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final AddTodoUsecase addTodoUsecase;
  AddTodoBloc(this.addTodoUsecase) : super(AddTodoInitial()) {
    on<AddTodo>((event, emit) async {
      emit(AddTodoLoading());
      final result = await addTodoUsecase.execute(event.title, event.description, event.category, event.dateTime);
      result.fold(
        (error) => emit(AddTodoError(error.message)),
        (data) => emit(AddTodoLoaded(data)),
      );
    });
  }
}
