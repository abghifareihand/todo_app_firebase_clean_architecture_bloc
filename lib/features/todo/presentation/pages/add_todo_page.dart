import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/components/custom_button.dart';
import 'package:todo_app/core/components/custom_field.dart';
import 'package:todo_app/core/components/custom_time.dart';
import 'package:todo_app/core/extension/nav_ext.dart';
import 'package:todo_app/features/todo/presentation/bloc/add_todo/add_todo_bloc.dart';

import '../../../../core/components/custom_date.dart';
import '../../data/datasources/notification_service.dart';
import '../widgets/select_category.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<TimeOfDay?> _selectedTime = ValueNotifier<TimeOfDay?>(null);
  final ValueNotifier<String?> _selectedCategory = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _selectedDate.dispose();
    _selectedTime.dispose();
    _selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomField.text(
            label: 'Title Task',
            controller: _titleController,
          ),
          SelectCategory(
            controller: _selectedCategory,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                child: CustomDate(
                  label: 'Date',
                  controller: _selectedDate,
                  initialDate: DateTime.now(),
                  onDateChanged: (newDate) {
                    _selectedDate.value = newDate;
                  },
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: CustomTime(
                  label: 'Time',
                  controller: _selectedTime,
                  onTimeChanged: (newTime) {
                    _selectedTime.value = newTime;
                  },
                ),
              ),
            ],
          ),
          CustomField.comment(
            label: 'Description',
            controller: _descriptionController,
            maxLines: 5,
          ),
          CustomButton(
            onPressed: () async {
              DateTime selectedDateTime = DateTime(
                _selectedDate.value!.year,
                _selectedDate.value!.month,
                _selectedDate.value!.day,
                _selectedTime.value!.hour,
                _selectedTime.value!.minute,
              );

              context.read<AddTodoBloc>().add(AddTodo(
                    _titleController.text,
                    _descriptionController.text,
                    _selectedCategory.value!,
                    selectedDateTime,
                  ));

              await NotificationService.addScheduleNotifications(
                title: _titleController.text,
                body: _descriptionController.text,
                scheduledDate: selectedDateTime,
              );
              if (!context.mounted) return;
              context.pop();
            },
            text: 'Create Task',
          ),
        ],
      ),
    );
  }
}
