import 'package:flutter/material.dart';
import 'package:todo_list_pro/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    _sortTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void toggleTaskStatus(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void updateTaskProgress(Task task, double progress) {
    if (progress >= task.progress) {
      // Ensure progress can only be increased
      task.progress = progress;
      if (progress == 1.0) {
        task.isDone = true; // Mark task as done if progress is 100%
      }
      notifyListeners();
    }
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a.isPriority && !b.isPriority) return -1;
      if (!a.isPriority && b.isPriority) return 1;
      return a.dateTime.compareTo(b.dateTime);
    });
  }
}
