import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/extension/date_ext.dart';

import '../bloc/delete_todo/delete_todo_bloc.dart';
import '../bloc/get_completed_todo/get_completed_todo_bloc.dart';

class DataTodoCompleted extends StatelessWidget {
  const DataTodoCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCompletedTodoBloc, GetCompletedTodoState>(
      bloc: context.read<GetCompletedTodoBloc>()..add(GetCompletedTodo()),
      builder: (context, state) {
        if (state is GetCompletedTodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetCompletedTodoError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetCompletedTodoLoaded) {
          if (state.todo.isEmpty) {
            return const Center(
              child: Text('TODO COMPLETED EMPTY'),
            );
          }
          return ListView.builder(
            itemCount: state.todo.length,
            itemBuilder: (context, index) {
              final todo = state.todo[index];
              return ListTile(
                onLongPress: () {
                  context.read<DeleteTodoBloc>().add(DeleteTodo(todo.id));
                },
                title: Text(
                  todo.title,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Text(
                  todo.description,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                trailing: Text(
                  todo.date.toFormattedDateTime(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('ERROR DATA'),
          );
        }
      },
    );
  }
}
