import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart'; 
import '../providers/tasks_provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String userName;

  UserProfileScreen({super.key, required this.userName});

 @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea( 
        child: Consumer<TasksProvider>(
          builder: (context, taskData, child) {
            int totalTasks = taskData.tasks.length;
            int completedTasks = taskData.tasks.where((task) => task.isCompleted).length;
            int highPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.high).length;
            int mediumPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.medium).length;
            int lowPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.low).length;
            
            return Card(
              
      
            color: Color.fromARGB(255, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column( // Remove IntrinsicWidth
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Make Column shrink-wrap height
                children: [
                Row( 
                  children: [
                    CircleAvatar( 
                      radius: 18,
                      backgroundColor: Color.fromARGB(255, 78, 76, 76),  // Example color
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : 'U', // First letter or 'U'
                        style: TextStyle(color: Colors.white), // Contrast with background
                      ), 
                    ),
                    SizedBox(width: 15),
                    Text("$userName", style: TextStyle(fontSize: 18,color: Colors.white)),
                  ],
                ),
                Text("Total Tasks: $totalTasks", style: TextStyle(color: Colors.white)),
                    Text("Tasks Completed: $completedTasks", style: TextStyle(color: Colors.white)),
                    Text("High Priority: $highPriorityTasks", style: TextStyle(color: Colors.white)), 
                    Text("Medium Priority: $mediumPriorityTasks", style: TextStyle(color: Colors.white)),
                    Text("Low Priority: $lowPriorityTasks", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          );
          }
        ),
      ),
    );
  
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/tasks_provider.dart';
// import '../models/task.dart'; // Assuming task.dart is in models folder

// class UserProfileScreen extends StatelessWidget {
//   final String userName;

//   UserProfileScreen({super.key, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Center( // Center the card within the body
//         child: Consumer<TasksProvider>(
//           builder: (context, taskData, child) {
//             int totalTasks = taskData.tasks.length;
//             int completedTasks = taskData.tasks.where((task) => task.isCompleted).length;
//             int highPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.high).length;
//             int mediumPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.medium).length;
//             int lowPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.low).length;

//             return Card(
//               color: Color.fromARGB(255, 0, 0, 0),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column( 
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row( 
//                       children: [
//                         CircleAvatar( 
//                           radius: 18,
//                           backgroundColor: Color.fromARGB(255, 78, 76, 76),
//                           child: Text(userName.isNotEmpty ? userName[0].toUpperCase() : 'U', style: TextStyle(color: Colors.white)), 
//                         ),
//                         SizedBox(width: 15),
//                         Text("$userName", style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ],
//                     ),
//                     SizedBox(height: 20), // Add spacing

//                     Text("Total Tasks: $totalTasks", style: TextStyle(color: Colors.white)),
//                     Text("Tasks Completed: $completedTasks", style: TextStyle(color: Colors.white)),
//                     Text("High Priority: $highPriorityTasks", style: TextStyle(color: Colors.white)), 
//                     Text("Medium Priority: $mediumPriorityTasks", style: TextStyle(color: Colors.white)),
//                     Text("Low Priority: $lowPriorityTasks", style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/task.dart'; 
// import '../providers/tasks_provider.dart';

// class UserProfileScreen extends StatelessWidget {
//   final String userName;

//   UserProfileScreen({super.key, required this.userName});

//  @override
//   Widget build(BuildContext context) {
//     int totalTasks = highPriority + mediumPriority + lowPriority; 

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//       ),
//       body: SafeArea( 
//   child: Consumer<TasksProvider>(
//           builder: (context, taskData, child) {
//             int totalTasks = taskData.tasks.length;
//             int completedTasks = taskData.tasks.where((task) => task.isCompleted).length;
//             int highPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.high).length;
//             int mediumPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.medium).length;
//             int lowPriorityTasks = taskData.tasks.where((task) => task.priority == Priority.low).length;

//             return Card(
      
//             color: Color.fromARGB(255, 0, 0, 0),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column( // Remove IntrinsicWidth
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min, // Make Column shrink-wrap height
//                 children: [
//                 Row( 
//                   children: [
//                     CircleAvatar( 
//                       radius: 18,
//                       backgroundColor: Color.fromARGB(255, 78, 76, 76),  // Example color
//                       child: Text(
//                         userName.isNotEmpty ? userName[0].toUpperCase() : 'U', // First letter or 'U'
//                         style: TextStyle(color: Colors.white), // Contrast with background
//                       ), 
//                     ),
//                     SizedBox(width: 15),
//                     Text("$userName", style: TextStyle(fontSize: 18,color: Colors.white)),
//                   ],
//                 ),
//                 Text("Total Tasks: $totalTasks", style: TextStyle(color: Colors.white)),
//                     Text("Tasks Completed: $completedTasks", style: TextStyle(color: Colors.white)),
//                     Text("High Priority: $highPriorityTasks", style: TextStyle(color: Colors.white)), 
//                     Text("Medium Priority: $mediumPriorityTasks", style: TextStyle(color: Colors.white)),
//                     Text("Low Priority: $lowPriorityTasks", style: TextStyle(color: Colors.white)),
//               ],
//             ),
//           ),
//           );
//           }
//         ),
//       ),
//     );
  
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/tasks_provider.dart'; 

// class UserProfileScreen extends StatelessWidget {
//   final String userName;

//   UserProfileScreen({super.key, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: SafeArea( 
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Card(
//             color: Color.fromARGB(255, 0, 0, 0),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Consumer<TasksProvider>(
//                 builder: (context, taskData, child) {
//                   int totalTasks = taskData.tasks.length;
//                   int completedTasks = taskData.tasks.where((task) => task.isCompleted).length;

//                   return Column( 
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Total Tasks: $totalTasks", style: TextStyle(color: Colors.white)),
//                       Text("Tasks Completed: $completedTasks", style: TextStyle(color: Colors.white)),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

