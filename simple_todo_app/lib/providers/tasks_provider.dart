import 'package:flutter/material.dart';
import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isEmpty = true; // Track emptiness
  // bool isCompleted = false;
   List<Task> get tasks => _tasks;

  bool get isEmpty => _isEmpty; // Getter 

  

  void addTask({required String title, required Priority priority}) {
    _tasks.add(Task(title: title, priority: priority));
    _isEmpty = false; 
    notifyListeners();
  }



  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted; 
    notifyListeners();
  }
}
