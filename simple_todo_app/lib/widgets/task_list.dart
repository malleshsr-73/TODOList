import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksProvider>(context);
    return taskData.tasks.isEmpty
        ? Center(child: Text('No Tasks Yet!'))
        : ListView.builder(
            itemCount: taskData.tasks.length,
            itemBuilder: (context, index) {
              return SizedBox( // Enclose in SizedBox
                height: 100,  // Set desired height for each card
                child: TaskTile(taskData.tasks[index]),
              );
            },
          );
  }
}
