import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_todo_usecase.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  final DeleteTodoUsecase deleteTodoUsecase;
  DeleteTodoBloc(this.deleteTodoUsecase) : super(DeleteTodoInitial()) {
    on<DeleteTodo>((event, emit) async {
      emit(DeleteTodoLoading());
      final result = await deleteTodoUsecase.execute(event.id);
      result.fold(
        (error) => emit(DeleteTodoError(error.message)),
        (data) => emit(DeleteTodoLoaded(data)),
      );
    });
  }
}
