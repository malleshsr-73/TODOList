import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

class TaskInput extends StatefulWidget {
  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final _taskController = TextEditingController();
  Priority? _selectedPriority = Priority.low;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Add a new task here'),
          ),
          SizedBox(height: 15), 
          DropdownButton<Priority>(
            value: _selectedPriority,
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
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              String newTask = _taskController.text.trim();
              if (newTask.isNotEmpty) {
                Provider.of<TasksProvider>(context, listen: false)
     .addTask(title: newTask, priority: _selectedPriority!); // Named parameters

                _taskController.clear();
                setState(() { 
                  _selectedPriority = Priority.low;
                });
              }
            },
            child: Text('Add'),
          )
        ],
      ),
    );
  }
}
