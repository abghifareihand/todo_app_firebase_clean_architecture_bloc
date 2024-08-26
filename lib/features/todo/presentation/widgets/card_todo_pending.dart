import 'package:flutter/material.dart';
import 'package:todo_app/core/extension/date_ext.dart';

import '../../domain/entities/todo.dart';

class CardTodoPending extends StatelessWidget {
  final Todo todo;
  const CardTodoPending({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    Color learningColor = Colors.green.withOpacity(0.2);
    Color workColor = Colors.blue.withOpacity(0.2);
    Color generalColor = Colors.amber.withOpacity(0.2);

    Color containerColor = todo.category == 'Learning'
        ? learningColor
        : todo.category == 'Work'
            ? workColor
            : generalColor;
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: containerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.category,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            todo.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
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
        ],
      ),
    );
  }
}
