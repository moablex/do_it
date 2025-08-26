import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> _tasks = [];
  @override
  void initState() {
    super.initState();

    _tasks = [
      Task(id: '1', title: 'Buy groceries', isCompleted: false),
      Task(id: '2', title: 'Walk the dog', isCompleted: true),
      Task(id: '3', title: 'Study', isCompleted: true),
      Task(id: '4', title: 'Play', isCompleted: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return TaskTile(task: task);
        },
        itemCount: _tasks.length,
      ),
    );
  }
}

class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});
}

class TaskTile extends StatelessWidget {
  ProgressIndicator indicator = new CircularProgressIndicator(
    strokeWidth: 4.0,
    color: Colors.blue,
    backgroundColor: Colors.deepPurple.shade100,
    value: 0.5,
  );
  final Task task;
  TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
          this.task.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 56, 57, 58), // Color of the text
          ),
        ),
        subtitle: Row(
          children: [Icon(Icons.watch_later_rounded), Text('  8:00 - 10:00')],
        ),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: 50, width: 50, child: indicator),
            Text(
              "50%",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
