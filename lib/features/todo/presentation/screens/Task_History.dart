import 'package:do_it/features/todo/presentation/widgets/History_calender.dart';
import 'package:do_it/features/todo/presentation/widgets/History_tile.dart';
import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';

class TaskHistory extends StatelessWidget {
  const TaskHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TimelineCalendar(),
                SizedBox(height: 20),
                TaskHistoryTIle(taskList: demoTaskList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Demo Task list
List<Task> demoTaskList = [
  // 1. COMPLETED Task (High Progress)
  Task(
    id: 'T-2025-01',
    title: 'Finalize Project Report',
    description:
        'Compile all section drafts, ensure consistency, and send the final PDF to the manager.',
    isCompleted: true,
    tags: ['Urgent', 'Documentation', 'Finished'],
    startTime: DateTime(2025, 10, 20, 10, 0),
    endTime: DateTime(2025, 10, 24, 17, 0),
    progress: 1.0,
    subTasks: [
      SubTask(
        id: 'ST-101',
        title: 'Gather section drafts',
        description: 'Collect inputs from all team members.',
        isCompleted: true,
      ),
      SubTask(
        id: 'ST-102',
        title: 'Proofread and edit',
        description: 'Check for grammar, flow, and consistency.',
        isCompleted: true,
      ),
      SubTask(
        id: 'ST-103',
        title: 'Generate final PDF',
        description: 'Export document and apply company watermark.',
        isCompleted: true,
      ),
    ],
  ),

  // 2. IN PROGRESS Task (Medium Progress)
  Task(
    id: 'T-2025-02',
    title: 'Set up Database Migrations',
    description:
        'Create new migration scripts for the user authentication tables and test rollback functionality.',
    isCompleted: false,
    tags: ['Backend', 'Database', 'WIP'],
    startTime: DateTime(2025, 10, 26, 9, 0),
    endTime: DateTime(2025, 10, 28, 12, 0),
    progress: 0.5,
    subTasks: [
      SubTask(
        id: 'ST-201',
        title: 'Write script for auth table',
        description: 'Define changes for user table schema.',
        isCompleted: true,
      ),
      SubTask(
        id: 'ST-202',
        title: 'Run test migration',
        description: 'Execute script on local dev environment.',
        isCompleted: false,
      ),
      SubTask(
        id: 'ST-203',
        title: 'Test rollback function',
        description: 'Verify database restores to previous state.',
        isCompleted: false,
      ),
    ],
    reminderTime: DateTime(2025, 10, 27, 10, 30),
  ),

  // 3. PENDING Task (Zero Progress)
  Task(
    id: 'T-2025-03',
    title: 'Design New Logo Options',
    description:
        'Brainstorm and create three distinct logo concepts for the new mobile application.',
    isCompleted: false,
    tags: ['Design', 'Creative'],
    startTime: DateTime(2025, 10, 30, 13, 0),
    endTime: DateTime(2025, 11, 1, 17, 0),
    progress: 0.0,
    subTasks: [
      SubTask(
        id: 'ST-301',
        title: 'Sketch initial ideas',
        description: 'Develop 10 rough concepts on paper/tablet.',
        isCompleted: false,
      ),
      SubTask(
        id: 'ST-302',
        title: 'Vectorize top 3 concepts',
        description: 'Create high-resolution digital versions.',
        isCompleted: false,
      ),
      SubTask(
        id: 'ST-303',
        title: 'Present to team',
        description: 'Schedule meeting and gather feedback.',
        isCompleted: false,
      ),
    ],
    reminderTime: DateTime(2025, 10, 30, 9, 0),
  ),
];
