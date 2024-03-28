import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/task_list.dart';
import '../widgets/task_input.dart';
import '../providers/tasks_provider.dart';
import '../screens/add_task_screen.dart';
import '../screens/user_profile_screen.dart'; 

class HomeScreen extends StatelessWidget {

final String user;
 const HomeScreen(String userName, {super.key, 
    required this.user,
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [ 
          IconButton(
            icon: CircleAvatar( // User avatar
              radius: 16, // Adjust radius as needed
              child: Icon(Icons.person), // Replace with actual user icon
            ),
            onPressed: () {
               // Get username from shared preferences or similar mechanism
              final username = user; // Replace with mechanism
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(
                    userName: username,
                    // ... Other values ...
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<TasksProvider>(
        builder: (context, taskData, child) {
          return Column(
            children: [
              if (taskData.isEmpty) // Check for emptiness
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('No Tasks Yet!'),
                        SizedBox(height: 20), 
                        // FloatingActionButton(
                        //   onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => AddTaskScreen()),
                        //   ),
                        //   child: Icon(Icons.add, size: 40),
                        // ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(child: TaskList()),
                
             Expanded(child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text('No Tasks Yet!'),
                        SizedBox(height: 20), 
                        FloatingActionButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddTaskScreen()),
                          ),
                          child: Icon(Icons.add, size: 40),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        }
      ),
    );
  }
}
