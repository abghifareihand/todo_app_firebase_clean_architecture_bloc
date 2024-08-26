import 'package:flutter/material.dart';
import 'package:todo_app/core/extension/date_ext.dart';

class CustomTime extends StatelessWidget {
  final String label;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay?> onTimeChanged;
  final ValueNotifier<TimeOfDay?> controller;

  const CustomTime({
    super.key,
    required this.label,
    this.initialTime,
    required this.onTimeChanged,
    required this.controller,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.value ?? TimeOfDay.now(),
    );
    if (picked != null && picked != controller.value) {
      controller.value = picked;
      onTimeChanged(picked);
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
            onTap: () => _selectTime(context),
            child: ValueListenableBuilder<TimeOfDay?>(
              valueListenable: controller,
              builder: (context, selectedTime, _) {
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
                      onTap: () => _selectTime(context),
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  child: Text(
                    selectedTime != null ? selectedTime.toFormattedTime() : 'hh:mm',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: selectedTime != null ? Colors.black : Colors.grey,
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
