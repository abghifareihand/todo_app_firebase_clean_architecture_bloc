import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/todo/presentation/widgets/card_todo.dart';

import '../bloc/get_date_todo/get_date_todo_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.blue,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                context.read<GetDateTodoBloc>().add(GetDateTodo(date));
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<GetDateTodoBloc, GetDateTodoState>(
              bloc: context.read<GetDateTodoBloc>()..add(GetDateTodo(DateTime.now())),
              builder: (context, state) {
                if (state is GetDateTodoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetDateTodoError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is GetDateTodoLoaded) {
                  if (state.todo.isEmpty) {
                    return const Center(
                      child: Text('TODO DATE NOW EMPTY'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todo.length,
                    itemBuilder: (context, index) {
                      final todo = state.todo[index];
                      return CardTodo(todo: todo);
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
