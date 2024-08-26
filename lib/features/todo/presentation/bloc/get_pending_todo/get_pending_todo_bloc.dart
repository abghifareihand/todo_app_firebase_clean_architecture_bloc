import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/get_pending_todo_usecase.dart';

part 'get_pending_todo_event.dart';
part 'get_pending_todo_state.dart';

class GetPendingTodoBloc extends Bloc<GetPendingTodoEvent, GetPendingTodoState> {
  final GetPendingTodoUsecase getPendingTodoUsecase;
  GetPendingTodoBloc(this.getPendingTodoUsecase) : super(GetPendingTodoInitial()) {
    on<GetPendingTodo>((event, emit) async {
      emit(GetPendingTodoLoading());
      final result = getPendingTodoUsecase.execute();
      await emit.forEach(
        result,
        onData: (data) => GetPendingTodoLoaded(data),
        onError: (_, error) => GetPendingTodoError(error.toString()),
      );
    });
  }
}
