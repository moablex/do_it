import 'package:do_it/features/todo/presentation/screens/task_detail.dart';
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
      Task(
        id: '1',
        title: 'Buy groceries',
        description: 'Get milk, bread, and eggs from the store.',
      ),
      Task(
        id: '2',
        title: 'Walk the dog',
        description: 'Take the dog for a 30-minute walk in the park.',
      ),
      Task(
        id: '3',
        title: 'Study',
        description: 'Review for the final exam in mathematics.',
      ),
      Task(
        id: '4',
        title: 'Play',
        description: 'Spend an hour playing video games with friends.',
      ),
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
  String description;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetail(task: task)),
          );
        },
      ),
    );
  }
}
