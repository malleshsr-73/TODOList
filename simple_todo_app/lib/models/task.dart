import 'package:flutter/material.dart';

enum Priority { low, medium, high }

class Task {
  final String title;
  bool isCompleted;
  final Priority priority;

  Task({required this.title, this.isCompleted = false, required this.priority});
}
