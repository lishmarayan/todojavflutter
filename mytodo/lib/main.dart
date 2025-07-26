import 'package:flutter/material.dart';
import 'todo.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Column(
          children: [
            Expanded(child: TodoPage()), // From todo.dart
          ],
        ),
      ),
    );
  }
}
