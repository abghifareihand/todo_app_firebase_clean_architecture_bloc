import 'package:flutter/material.dart';
import 'package:todo_app/core/extension/date_ext.dart';

import '../../domain/entities/todo.dart';

class CardTodoCompleted extends StatelessWidget {
  final Todo todo;
  const CardTodoCompleted({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    Color learningColor = Colors.green;
    Color workColor = Colors.blue;
    Color generalColor = Colors.amber;

    Color containerColor = todo.category == 'Learning'
        ? learningColor
        : todo.category == 'Work'
            ? workColor
            : generalColor;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.category,
            style: TextStyle(
              color: containerColor,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            todo.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    todo.date.toFormattedDateTime(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: containerColor.withOpacity(0.2),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: containerColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
