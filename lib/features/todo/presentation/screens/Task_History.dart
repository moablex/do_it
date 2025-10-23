import 'package:do_it/features/todo/presentation/widgets/History_calender.dart';
import 'package:flutter/material.dart';

class TaskHistory extends StatelessWidget {
  const TaskHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(children: [SizedBox(height: 20), TimelineCalendar()]),
      ),
    );
  }
}
