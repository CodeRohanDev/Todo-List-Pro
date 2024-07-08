import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  bool isPriority;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  double progress;

  Task({
    required this.title,
    required this.dateTime,
    this.isPriority = false,
    this.isCompleted = false,
    this.progress = 0.0,
  });

  bool get isExpired {
    return !isCompleted && dateTime.isBefore(DateTime.now());
  }
}
