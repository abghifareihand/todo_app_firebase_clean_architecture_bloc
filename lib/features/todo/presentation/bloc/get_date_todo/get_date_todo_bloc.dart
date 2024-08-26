import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/usecases/get_date_todo_usecase.dart';

import '../../../domain/entities/todo.dart';

part 'get_date_todo_event.dart';
part 'get_date_todo_state.dart';

class GetDateTodoBloc extends Bloc<GetDateTodoEvent, GetDateTodoState> {
  final GetDateTodoUsecase getDateTodoUsecase;
  GetDateTodoBloc(this.getDateTodoUsecase) : super(GetDateTodoInitial()) {
    on<GetDateTodo>((event, emit) async {
      emit(GetDateTodoLoading());
      try {
        final result = getDateTodoUsecase.execute(event.date);
        await emit.forEach(
          result,
          onData: (data) => GetDateTodoLoaded(data),
          onError: (_, error) => GetDateTodoError(error.toString()),
        );
      } catch (e) {
        emit(GetDateTodoError(e.toString()));
      }
    });
  }
}
