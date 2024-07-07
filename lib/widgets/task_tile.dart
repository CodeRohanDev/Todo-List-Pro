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
    final DateFormat dateFormat = DateFormat('MMM dd, HH:mm:ss');
    final String formattedDateTime = dateFormat.format(task.dateTime);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: Icon(
          task.isPriority ? Icons.star : Icons.star_border,
          color: task.isPriority ? Colors.amber : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Due: $formattedDateTime',
              style: TextStyle(
                fontSize: 14.0,
                color: task.isPriority ? Colors.red : Colors.black,
              ),
            ),
            LinearProgressIndicator(
              value: task.progress,
              backgroundColor: Colors.grey[200],
              color: task.isPriority ? Colors.red : Colors.blue,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .toggleTaskStatus(task);
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => EditTaskDialog(task: task),
                );
              },
            ),
          ],
        ),
        onLongPress: () {
          Provider.of<TaskProvider>(context, listen: false).removeTask(task);
        },
      ),
    );
  }
}
