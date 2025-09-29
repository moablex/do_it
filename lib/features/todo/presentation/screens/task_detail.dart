import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  final Task task;
  const TaskDetail({super.key, required this.task});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Text('${widget.task.title}'),
              SizedBox(height: 10),
              Expanded(child: Text('${widget.task.description}')),
              SizedBox(width: 10),
              Chip(label: Text('Completed')),
            ],
          ),
        ],
      ),
    );
  }
}
