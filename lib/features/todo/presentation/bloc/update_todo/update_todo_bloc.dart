import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_todo_status_usecase.dart';
import '../../../domain/usecases/update_todo_usecase.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  final UpdateTodoUsecase updateTodoUsecase;
  final UpdateTodoStatusUsecase updateTodoStatusUsecase;
  UpdateTodoBloc(this.updateTodoUsecase, this.updateTodoStatusUsecase) : super(UpdateTodoInitial()) {
    on<UpdateTodo>((event, emit) async {
      emit(UpdateTodoLoading());
      final result = await updateTodoUsecase.execute(
        event.id,
        event.title,
        event.description,
        event.category,
      );
      result.fold(
        (error) => emit(UpdateTodoError(error.message)),
        (data) => emit(UpdateTodoLoaded(data)),
      );
    });
    on<UpdateTodoStatus>((event, emit) async {
      emit(UpdateTodoLoading());
      final result = await updateTodoStatusUsecase.execute(event.id, event.status);
      result.fold(
        (error) => emit(UpdateTodoError(error.message)),
        (data) => emit(UpdateTodoLoaded(data)),
      );
    });
  }
}
