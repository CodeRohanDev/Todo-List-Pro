import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_pro/models/task.dart';
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
          return Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: ListView(
              children: [
                _buildSection(
                  context,
                  'Outgoing Tasks',
                  taskProvider.outgoingTasks,
                ),
                _buildSection(
                  context,
                  'Completed Tasks',
                  taskProvider.completedTasks,
                ),
                _buildSection(
                  context,
                  'Expired Tasks',
                  taskProvider.expiredTasks,
                ),
              ],
            ),
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

  Widget _buildSection(BuildContext context, String title, List<Task> tasks) {
    return tasks.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: TaskTile(task: task),
                  );
                },
              ),
            ],
          )
        : SizedBox();
  }
}
