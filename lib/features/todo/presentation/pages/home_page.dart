import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:todo_app/core/components/circular_percentage.dart';
import 'package:todo_app/features/todo/presentation/widgets/card_todo_completed.dart';
import 'package:todo_app/features/todo/presentation/widgets/card_todo_pending.dart';

import '../bloc/get_completed_todo/get_completed_todo_bloc.dart';
import '../bloc/get_date_todo/get_date_todo_bloc.dart';
import '../bloc/get_pending_todo/get_pending_todo_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
              ),
              FutureBuilder(
                future: GetIt.I<AuthLocalDatasource>().getAuthData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    );
                  } else {
                    return Text(
                      snapshot.data!.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          // Congtainer progress
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blue,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Your today task almost done!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
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
                      final totalTasks = state.todo.length.toDouble();
                      final completedTasks = state.todo.where((task) => task.status).length.toDouble();
                      final percentage = totalTasks > 0 ? (completedTasks / totalTasks) * 100.0 : 0.0;
                      if (state.todo.isEmpty) {
                        return const Expanded(
                          child: TaskCompletionIndicator(
                            percentage: 0,
                          ),
                        );
                      }
                      return Expanded(
                        child: TaskCompletionIndicator(
                          percentage: percentage,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),

          // Get Todo All. Inprogress, Done
          BlocBuilder<GetPendingTodoBloc, GetPendingTodoState>(
            bloc: context.read<GetPendingTodoBloc>()..add(GetPendingTodo()),
            builder: (context, state) {
              if (state is GetPendingTodoLoaded) {
                if (state.todo.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Todo In Progress',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.todo.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16.0,
                        ),
                        itemBuilder: (context, index) {
                          final todo = state.todo[index];
                          return CardTodoPending(todo: todo);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),

          BlocBuilder<GetCompletedTodoBloc, GetCompletedTodoState>(
            bloc: context.read<GetCompletedTodoBloc>()..add(GetCompletedTodo()),
            builder: (context, state) {
              if (state is GetCompletedTodoLoaded) {
                if (state.todo.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Todo Completed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.todo.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        final todo = state.todo[index];
                        return CardTodoCompleted(todo: todo);
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
