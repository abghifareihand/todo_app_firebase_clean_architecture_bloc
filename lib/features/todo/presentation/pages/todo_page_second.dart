import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_todo/add_todo_bloc.dart';
import '../bloc/delete_todo/delete_todo_bloc.dart';
import '../bloc/get_pending_todo/get_pending_todo_bloc.dart';

class TodoPageSecond extends StatelessWidget {
  const TodoPageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('List Todo'),
      ),
      body: BlocBuilder<GetPendingTodoBloc, GetPendingTodoState>(
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
                child: Text('TODO KOSONG'),
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
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                );
              },
            );
          } else {
            return const Center(
              child: Text('EMPTY TODOS'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddTodoDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add User'),
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
                context.read<AddTodoBloc>().add(AddTodo(
                      titleController.text,
                      descriptionController.text,
                      'Category',
                      DateTime.now(),
                    ));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
