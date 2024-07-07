import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_pro/models/task.dart';
import 'package:todo_list_pro/providers/task_provider.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;

  EditTaskDialog({required this.task});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.task.progress ?? 0.0; // Ensuring a default value of 0.0
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text('Edit Task', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.task.title, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('Set Progress', style: TextStyle(fontSize: 16)),
          Slider(
            value: _progress,
            min: widget.task.progress,
            onChanged: (newProgress) {
              if (newProgress >= widget.task.progress) {
                setState(() {
                  _progress = newProgress;
                });
              }
            },
            divisions: 20,
            label: "${(_progress * 100).round()}%",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<TaskProvider>(context, listen: false)
                .updateTaskProgress(widget.task, _progress);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Save'),
        ),
      ],
    );
  }
}
