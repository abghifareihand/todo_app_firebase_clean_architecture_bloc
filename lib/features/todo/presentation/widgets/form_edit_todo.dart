import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/components/custom_button.dart';
import 'package:todo_app/core/components/custom_field.dart';
import 'package:todo_app/core/components/custom_time.dart';
import 'package:todo_app/core/components/custom_date.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_todo/update_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/widgets/select_category.dart';

class FormEditTodo extends StatefulWidget {
  final Todo todo;

  const FormEditTodo({super.key, required this.todo});

  @override
  State<FormEditTodo> createState() => _FormEditTodoState();
}

class _FormEditTodoState extends State<FormEditTodo> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final ValueNotifier<DateTime?> selectedDate;
  late final ValueNotifier<TimeOfDay?> selectedTime;
  late final ValueNotifier<String?> selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
    selectedDate = ValueNotifier<DateTime?>(widget.todo.date);
    selectedTime = ValueNotifier<TimeOfDay?>(
      TimeOfDay(hour: widget.todo.date.hour, minute: widget.todo.date.minute),
    );
    selectedCategory = ValueNotifier<String?>(widget.todo.category);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    selectedDate.dispose();
    selectedTime.dispose();
    selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white, // Ensure the background color is set
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Edit Task Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomField.text(
            label: 'Title Task',
            controller: titleController,
          ),
          SelectCategory(
            controller: selectedCategory,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CustomDate(
                  label: 'Date',
                  controller: selectedDate,
                  initialDate: selectedDate.value!,
                  onDateChanged: (newDate) {
                    selectedDate.value = newDate;
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: CustomTime(
                  label: 'Time',
                  controller: selectedTime,
                  onTimeChanged: (newTime) {
                    selectedTime.value = newTime;
                  },
                ),
              ),
            ],
          ),
          CustomField.comment(
            label: 'Description',
            controller: descriptionController,
            maxLines: 5,
          ),
          CustomButton(
            onPressed: () {
              final updatedDateTime = DateTime(
                selectedDate.value!.year,
                selectedDate.value!.month,
                selectedDate.value!.day,
                selectedTime.value!.hour,
                selectedTime.value!.minute,
              );

              context.read<UpdateTodoBloc>().add(UpdateTodo(
                    widget.todo.id,
                    titleController.text,
                    descriptionController.text,
                    selectedCategory.value!,
                  ));

              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
            text: 'Update Task',
          ),
        ],
      ),
    );
  }
}
