import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/providers/tasks_provider.dart';
import 'package:simple_todo_app/screens/home_screen.dart';
import 'screens/signin_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: SigninScreen(),
      ),
    );
  }
}

