// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_pro/models/task.dart';
import 'package:todo_list_pro/providers/task_provider.dart';
import 'package:todo_list_pro/widgets/edit_task_dialog.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd-MM-yyyy HH:mm')
                  .format(task.dateTime), // Format date and time
            ),
            if (task.progress != null) // Check if progress is not null
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: task.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: _getProgressColor(task.progress),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${(task.progress * 100).toInt()}%", // Display percentage
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
          ],
        ),
        trailing: Wrap(
          spacing: 12,
          children: [
            _buildEditButton(context),
            _buildCheckbox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    if (task.isCompleted || task.isExpired) {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: null, // Disable edit button
      );
    } else {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EditTaskDialog(task: task),
          );
        },
      );
    }
  }

  Widget _buildCheckbox(BuildContext context) {
    if (task.isCompleted || task.isExpired) {
      return Checkbox(
        value: task.isCompleted,
        onChanged: null, // Disable checkbox
      );
    } else {
      return Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          task.isCompleted = value!;
          Provider.of<TaskProvider>(context, listen: false).updateTask(task);
        },
      );
    }
  }

  Animation<Color?>? _getProgressColor(double progress) {
    if (progress >= 1.0) {
      return AlwaysStoppedAnimation<Color>(
          Colors.green); // Green color when progress is 100%
    } else if (progress >= 0.6) {
      return AlwaysStoppedAnimation<Color>(
          Colors.lightGreen); // Light green color for 60-99% progress
    } else if (progress >= 0.3) {
      return AlwaysStoppedAnimation<Color>(
          Colors.yellow); // Yellow color for 30-59% progress
    } else {
      return AlwaysStoppedAnimation<Color>(
          Colors.red); // Red color for less than 30% progress
    }
  }
}
