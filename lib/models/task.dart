import 'package:flutter/material.dart';

class Task {
  final String title;
  final DateTime dateTime;
  bool isDone;
  final bool isPriority;
  double progress;

  Task({
    required this.title,
    required this.dateTime,
    this.isDone = false,
    this.isPriority = false,
    this.progress = 0.0,
  });
}
