import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/extension/date_ext.dart';
import 'package:todo_app/core/extension/nav_ext.dart';
import 'package:todo_app/features/todo/presentation/bloc/delete_todo/delete_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_todo/update_todo_bloc.dart';

import '../../domain/entities/todo.dart';
import 'form_edit_todo.dart';

class CardTodo extends StatelessWidget {
  final Todo todo;
  const CardTodo({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    const Color learningColor = Colors.green;
    const Color workColor = Colors.blue;
    const Color generalColor = Colors.amber;

    Color containerColor = todo.category == 'Learning'
        ? learningColor
        : todo.category == 'Work'
            ? workColor
            : generalColor;
    Colors.grey;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          builder: (context) {
            // edit todo
            return FormEditTodo(todo: todo);
          },
        );
      },
      onLongPress: () {
        _showDeleteConfirmationDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.status ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        todo.description,
                        style: TextStyle(
                          decoration: todo.status ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          activeColor: Colors.blue,
                          value: todo.status,
                          onChanged: (value) {
                            context.read<UpdateTodoBloc>().add(UpdateTodoStatus(todo.id, value!));
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          todo.date.toFormattedDateTime(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context.read<DeleteTodoBloc>().add(DeleteTodo(todo.id));
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
