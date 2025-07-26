import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final int completed;
  final int total;

  const CustomAppBar({super.key, required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    TextStyle headingStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    TextStyle subHeadingStyle = const TextStyle(color: Colors.white70);

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Color.fromARGB(255, 221, 132, 236)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.list, color: Colors.white),
          const SizedBox(height: 10),
          Text("To-Do App", style: headingStyle),
          const SizedBox(height: 5),
          Text("$completed of $total tasks completed", style: subHeadingStyle),
        ],
      ),
    );
  }
}
