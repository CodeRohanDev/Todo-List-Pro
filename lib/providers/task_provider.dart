import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_pro/models/task.dart';

class TaskProvider extends ChangeNotifier {
  Box<Task> _taskBox = Hive.box<Task>('tasks');

  List<Task> get tasks => _taskBox.values.toList();

  List<Task> get outgoingTasks =>
      tasks.where((task) => !task.isCompleted && !task.isExpired).toList();

  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();

  List<Task> get expiredTasks =>
      tasks.where((task) => !task.isCompleted && task.isExpired).toList();

  void addTask(Task task) {
    _taskBox.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.save();
    notifyListeners();
  }

  void updateTaskProgress(Task task, double progress) {
    task.progress = progress;
    task.save();
    notifyListeners();
  }

  void deleteTask(Task task) {
    task.delete();
    notifyListeners();
  }
}
