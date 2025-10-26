import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TaskHistoryTIle extends StatelessWidget {
  final List<Task> taskList;

  const TaskHistoryTIle({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('hh:mm a');
    return ListView.builder(
      itemCount: taskList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = taskList[index];
        final isFirst = index == 0;
        final isLast = index == taskList.length - 1;
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.2,
          isFirst: isFirst,
          isLast: isLast,
          startChild: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              task.startTime != null
                  ? dateFormat.format(task.startTime!)
                  : DateTime.now().toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.right,
            ),
          ),
          endChild: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
