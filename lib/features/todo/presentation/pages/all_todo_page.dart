import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/extension/nav_ext.dart';
import 'package:todo_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todo_app/features/todo/presentation/pages/data_todo_completed.dart';
import 'package:todo_app/features/todo/presentation/pages/data_todo_pending.dart';

import '../bloc/add_todo/add_todo_bloc.dart';

class AllTodoPage extends StatelessWidget {
  const AllTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 2,
          title: const Text('All Todo Page'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.5,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            DataTodoPending(),
            DataTodoCompleted(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showAddTodoDialog(context);
            context.push(const AddTodoPage());
          },
          child: const Icon(Icons.add),
        ),
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
          title: const Text('Add Todo'),
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
