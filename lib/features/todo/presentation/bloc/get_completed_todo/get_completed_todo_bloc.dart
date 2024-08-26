import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/get_completed_todo_usecase.dart';

part 'get_completed_todo_event.dart';
part 'get_completed_todo_state.dart';

class GetCompletedTodoBloc extends Bloc<GetCompletedTodoEvent, GetCompletedTodoState> {
  final GetCompletedTodoUsecase getCompletedTodoUsecase;
  GetCompletedTodoBloc(this.getCompletedTodoUsecase) : super(GetCompletedTodoInitial()) {
    on<GetCompletedTodo>((event, emit) async {
      emit(GetCompletedTodoLoading());
      final result = getCompletedTodoUsecase.execute();
      await emit.forEach(
        result,
        onData: (data) => GetCompletedTodoLoaded(data),
        onError: (_, error) => GetCompletedTodoError(error.toString()),
      );
    });
  }
}
