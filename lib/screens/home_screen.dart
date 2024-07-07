import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_pro/providers/task_provider.dart';
import 'package:todo_list_pro/widgets/add_task_dialog.dart';
import 'package:todo_list_pro/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskTile(task: task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTaskDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
