import 'package:flutter/material.dart';

class FormRegisterPage extends StatefulWidget {
  const FormRegisterPage({super.key});

  @override
  State<FormRegisterPage> createState() => _FormRegisterPageState();
}

class _FormRegisterPageState extends State<FormRegisterPage> {
  final _nameController = TextEditingController();
  final _birthDateNotifier = ValueNotifier<DateTime?>(null);
  final _arrivalDateNotifier = ValueNotifier<DateTime?>(null);
  final _arrivalTimeNotifier = ValueNotifier<TimeOfDay?>(null);
  final _genderNotifier = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateNotifier.dispose();
    _arrivalDateNotifier.dispose();
    _arrivalTimeNotifier.dispose();
    _genderNotifier.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, ValueNotifier<DateTime?> notifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != notifier.value) {
      notifier.value = picked;
    }
  }

  Future<void> _selectTime(BuildContext context, ValueNotifier<TimeOfDay?> notifier) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != notifier.value) {
      notifier.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Nama
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),

            const SizedBox(height: 16.0),

            // Tanggal Lahir
            ValueListenableBuilder<DateTime?>(
              valueListenable: _birthDateNotifier,
              builder: (context, birthDate, _) {
                return ListTile(
                  title: const Text('Tanggal Lahir'),
                  subtitle: Text(birthDate != null ? '${birthDate.day}-${birthDate.month}-${birthDate.year}' : 'Pilih Tanggal Lahir'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, _birthDateNotifier),
                );
              },
            ),

            const SizedBox(height: 16.0),

            // Tanggal Kedatangan
            ValueListenableBuilder<DateTime?>(
              valueListenable: _arrivalDateNotifier,
              builder: (context, arrivalDate, _) {
                return ListTile(
                  title: const Text('Tanggal Kedatangan'),
                  subtitle: Text(arrivalDate != null ? '${arrivalDate.day}-${arrivalDate.month}-${arrivalDate.year}' : 'Pilih Tanggal Kedatangan'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, _arrivalDateNotifier),
                );
              },
            ),

            const SizedBox(height: 16.0),

            // Jam Kedatangan
            ValueListenableBuilder<TimeOfDay?>(
              valueListenable: _arrivalTimeNotifier,
              builder: (context, arrivalTime, _) {
                return ListTile(
                  title: const Text('Jam Kedatangan'),
                  subtitle: Text(arrivalTime != null ? arrivalTime.format(context) : 'Pilih Jam Kedatangan'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _selectTime(context, _arrivalTimeNotifier),
                );
              },
            ),

            const SizedBox(height: 16.0),

            // Gender
            ValueListenableBuilder<String?>(
              valueListenable: _genderNotifier,
              builder: (context, gender, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gender'),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Male'),
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              _genderNotifier.value = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Female'),
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              _genderNotifier.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16.0),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Handle save logic here
                print('Nama: ${_nameController.text}');
                print('Tanggal Lahir: ${_birthDateNotifier.value}');
                print('Tanggal Kedatangan: ${_arrivalDateNotifier.value}');
                print('Jam Kedatangan: ${_arrivalTimeNotifier.value}');
                print('Gender: ${_genderNotifier.value}');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
