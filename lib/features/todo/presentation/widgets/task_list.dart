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
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(title: Text(this.task.title)),
    );
  }
}
