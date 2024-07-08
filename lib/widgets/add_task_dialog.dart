// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, curly_braces_in_flow_control_structures, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_pro/models/task.dart';
import 'package:todo_list_pro/providers/task_provider.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _isPriority = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    _selectedDateTime = await _selectDateTime(context);
                    setState(() {}); // Update state after selecting date
                  },
                  child: Text(_selectedDateTime == null
                      ? 'Select Date & Time'
                      : 'Change Date & Time'),
                ),
              ),
            ],
          ),
          if (_selectedDateTime != null) // Display selected date and time
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Selected Date & Time: ${DateFormat('dd-MM-yyyy HH:mm').format(_selectedDateTime!)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _isPriority,
                onChanged: (value) {
                  setState(() {
                    _isPriority = value!;
                  });
                },
              ),
              Text('Priority'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_taskController.text.isEmpty || _selectedDateTime == null)
              return;
            final newTask = Task(
              title: _taskController.text,
              dateTime: _selectedDateTime!,
              isPriority: _isPriority,
            );
            Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
            Navigator.of(context).pop();
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
    return null;
  }
}
