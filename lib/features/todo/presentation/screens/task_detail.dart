import 'package:do_it/features/todo/presentation/widgets/Add_Sub_Task.dart';
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
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${widget.task.title}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Chip(label: Text('50 % Progress')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.task.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Sub Tasks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              AddSubTask(),
            ],
          ),
          if (widget.task.subTasks.isEmpty) Center(child: Text('No Sub Tasks')),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey.shade300,
              color: Colors.teal,
              minHeight: 6,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children:
                widget.task.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.teal.shade50,
                        labelStyle: const TextStyle(color: Colors.teal),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
