import 'package:flutter/material.dart';
import 'api.dart'; // Import the API file
import 'appbar.dart'; // Import custom app bar if needed

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> tasks = []; // Store tasks locally

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      final data = await ApiService.getTasks();
      setState(() {
        tasks = data;
      });
    } catch (e) {
      print("Failed to load tasks: $e");
    }
  }

  void addTask() async {
    String taskText = _controller.text.trim();
    if (taskText.isEmpty) return;

    try {
      final newTask = await ApiService.createTask(taskText);
      setState(() {
        tasks.add(newTask);
        _controller.clear();
      });
    } catch (e) {
      print("Failed to add task: $e");
    }
  }

  void updateTask(int index, bool? value) async {
    try {
      final task = tasks[index];
      final updatedTask =
          await ApiService.updateTask(task['id'], value ?? false);
      setState(() {
        tasks[index] = updatedTask;
      });
    } catch (e) {
      print("Failed to update task: $e");
    }
  }

  void deleteTask(int index) async {
    try {
      final task = tasks[index];
      await ApiService.deleteTask(task['id']);
      setState(() {
        tasks.removeAt(index);
      });
    } catch (e) {
      print("Failed to delete task: $e");
    }
  }

  int get completedCount {
    return tasks.where((task) => task['completed'] == true).length;
  }


@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      // Background Image with watermark effect
      Positioned.fill(
        child: Opacity(
          opacity: 0.7,  // Light wash-out effect (adjust as needed)
          child: Image.asset(
            'assets/images/bg2.jpg',  // Your background image
            fit: BoxFit.cover,
          ),
        ),
      ),

      // Main UI content
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top container with centered heading & subtitle
          Container(
            margin: EdgeInsets.only(top: 10, left: 16, right: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(
      'assets/images/ic.png',
      width: 30,
      height: 30,
    ),
    SizedBox(width: 10),
    Text(
      "Todo App",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

                SizedBox(height: 10),
                Text(
                  "$completedCount of ${tasks.length} task completed",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Task input field (centered placeholder text)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,  // Center placeholder & text
                    decoration: InputDecoration(
                      hintText: "What needs to be done?",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFFBDC3C7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF8E44AD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: addTask,
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFECF0F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: Color(0xFF4CAF50),
                          value: task['completed'] == true,
                          onChanged: (val) {
                            updateTask(index, val);
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'] ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              Text(
                                task['date'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => deleteTask(index),
                          child: Icon(Icons.delete_outline, color: Color(0xFFe74c3c)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
}








}