import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/extension/date_ext.dart';

import '../../domain/entities/todo.dart';
import '../bloc/delete_todo/delete_todo_bloc.dart';
import '../bloc/get_pending_todo/get_pending_todo_bloc.dart';
import '../bloc/update_todo/update_todo_bloc.dart';

class DataTodoPending extends StatelessWidget {
  const DataTodoPending({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPendingTodoBloc, GetPendingTodoState>(
      bloc: context.read<GetPendingTodoBloc>()..add(GetPendingTodo()),
      builder: (context, state) {
        if (state is GetPendingTodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetPendingTodoError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetPendingTodoLoaded) {
          if (state.todo.isEmpty) {
            return const Center(
              child: Text('TODO PENDING EMPTY'),
            );
          }
          return ListView.builder(
            itemCount: state.todo.length,
            itemBuilder: (context, index) {
              final todo = state.todo[index];

              return Slidable(
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showEditTodoDialog(context, todo);
                      },
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        context.read<DeleteTodoBloc>().add(DeleteTodo(todo.id));
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<UpdateTodoBloc>().add(UpdateTodoStatus(todo.id, true));
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.check,
                      label: 'Mask',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Text(
                    todo.date.toFormattedDateTime(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
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

  void showEditTodoDialog(BuildContext context, Todo todo) {
    final TextEditingController titleController = TextEditingController(text: todo.title);
    final TextEditingController descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<UpdateTodoBloc>().add(UpdateTodo(
                      todo.id,
                      titleController.text,
                      descriptionController.text,
                      'General',
                    ));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
