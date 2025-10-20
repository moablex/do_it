import 'package:do_it/features/todo/presentation/screens/task_detail.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> _tasks = [];
  List<String> demoTags1 = ['Spritual', 'High priority'];
  List<String> demoTags2 = ['Financial', 'Work'];
  List<String> demoTags3 = ['Study', 'Personal'];

  @override
  void initState() {
    super.initState();

    _tasks = [
      Task(
        id: '1',
        title: 'Buy groceries',
        description: 'Get milk, bread, and eggs from the store.',
        tags: demoTags1,
      ),
      Task(
        id: '2',
        title: 'Walk the dog',
        description: 'Take the dog for a 30-minute walk in the park.',
        tags: demoTags2,
      ),
      Task(
        id: '3',
        title: 'Study',
        description: 'Review for the final exam in mathematics.',
        tags: demoTags3,
      ),
      Task(
        id: '4',
        title: 'Play',
        description: 'Spend an hour playing video games with friends.',
        tags: demoTags3,
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

// Sub Task model that defines the sub task object
class SubTask {
  final String id;
  String title;
  String description;
  bool isCompleted;
  SubTask({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}

// Task modle that defines the task object
class Task {
  final String id;
  String title;
  String description;
  bool isCompleted;
  List<String> tags;
  DateTime? startTime;
  DateTime? endTime;
  double progress;

  List<SubTask> subTasks;
  DateTime? reminderTime;
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.tags = const [],
    this.subTasks = const [],
    this.progress = 0.0,
    this.reminderTime,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
    for (var subTask in subTasks) {
      subTask.toggleCompleted();
    }
  }

  double calculateProgress() {
    if (subTasks.isEmpty) return isCompleted ? 1.0 : 0.0;
    int completedTasks =
        subTasks.where((task) => task.isCompleted == true).length;
    return completedTasks / subTasks.length;
  }
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
