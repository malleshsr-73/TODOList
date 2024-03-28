import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart'; 

class TaskTile extends StatefulWidget {
  final Task task;
  TaskTile(this.task);

  @override
  _TaskTileState createState() => _TaskTileState(task);
}
class _TaskTileState extends State<TaskTile> {
  final Task task;
  _TaskTileState(this.task);

  bool _isChecked = false; // Initial checkbox state

  // Function to get appropriate card color
  Color _getColor(Priority priority) {
    if (widget.task.isCompleted) {
      // Lighter colors for completed tasks
      switch (priority) {
        case Priority.high:
          return Colors.red.withOpacity(0.6); // Example
        case Priority.medium:
          return Colors.orange.withOpacity(0.6);
        case Priority.low:
          return Colors.green.withOpacity(0.6);
      }
    } else {
      // Original colors for unchecked tasks
      switch (priority) {
        case Priority.high:
          return Colors.red;
        case Priority.medium:
          return Colors.orange;
        case Priority.low:
          return Colors.green;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.isCompleted; // Initialize the checkbox state
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Add a Container for the grey background
      color: const Color.fromARGB(255, 191, 182, 182),
      padding: EdgeInsets.all(5), // Add padding for visual spacing
      child: Card(
        color: _getColor(task.priority),
        child: ListTile(
          title: Text( // No need for Expanded here
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row( // Use Row for horizontal arrangement
            mainAxisSize: MainAxisSize.min, // Keep Row as small as possible
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  Provider.of<TasksProvider>(context, listen: false).toggleTask(task);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false).deleteTask(task);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

