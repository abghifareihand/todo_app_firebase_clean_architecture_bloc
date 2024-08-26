import 'package:flutter/material.dart';
import 'package:todo_app/core/extension/date_ext.dart';

class CustomDate extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateChanged;
  final ValueNotifier<DateTime?> controller;

  const CustomDate({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateChanged,
    required this.controller,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != controller.value) {
      controller.value = picked;
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () => _selectDate(context),
            child: ValueListenableBuilder<DateTime?>(
              valueListenable: controller,
              builder: (context, selectedDate, _) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 12.0,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => _selectDate(context),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  child: Text(
                    selectedDate != null ? selectedDate.toFormattedDate() : 'dd/mm/yyyy',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: selectedDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
