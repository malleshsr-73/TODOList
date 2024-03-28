import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  Priority? _selectedPriority = Priority.low;

  void _addTask(BuildContext context) {
    final newTask = _taskController.text.trim();
    if (newTask.isNotEmpty) {
      Provider.of<TasksProvider>(context, listen: false)
          .addTask(title: newTask, priority: _selectedPriority!);
      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(hintText: 'Enter task title'),
                ),
                const SizedBox(height: 20),
                DropdownButton<Priority>(
                  value: _selectedPriority,
                  isExpanded: true, // Make dropdown full width
                  items: Priority.values.map((Priority value) {
                    return DropdownMenuItem<Priority>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPriority = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addTask(context);
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
