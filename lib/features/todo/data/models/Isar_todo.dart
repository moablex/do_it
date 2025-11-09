// lib/features/todo/data/models/Isar_todo.dart

import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:isar/isar.dart';

part 'Isar_todo.g.dart';

@embedded
class IsarSubTask {
  IsarSubTask();

  late String id;
  late String title;
  late String description;
  bool isCompleted = false;

  SubTask toDomain() => SubTask(
    id: id,
    title: title,
    description: description,
    isCompleted: isCompleted,
  );

  factory IsarSubTask.fromDomain(SubTask sub) =>
      IsarSubTask()
        ..id = sub.id
        ..title = sub.title
        ..description = sub.description
        ..isCompleted = sub.isCompleted;
}

@Collection()
class IsarTask {
  IsarTask();
  Id? isarId;

  @Index(unique: true)
  late String id;

  late String title;
  late String description;
  bool isCompleted = false;

  @Index(type: IndexType.value)
  List<String> tags = const [];

  int? startTime;
  int? endTime;
  double progress = 0.0;
  int? reminderTime;

  List<IsarSubTask> subTasks = [];

  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      tags: tags,
      startTime:
          startTime != null
              ? DateTime.fromMillisecondsSinceEpoch(startTime!)
              : null,
      endTime:
          endTime != null
              ? DateTime.fromMillisecondsSinceEpoch(endTime!)
              : null,
      progress: progress,
      reminderTime:
          reminderTime != null
              ? DateTime.fromMillisecondsSinceEpoch(reminderTime!)
              : null,
      subTasks: subTasks.map((e) => e.toDomain()).toList(),
    );
  }

  factory IsarTask.fromDomain(Task task) {
    return IsarTask()
      ..id = task.id
      ..title = task.title
      ..description = task.description
      ..isCompleted = task.isCompleted
      ..tags = task.tags
      ..progress = task.progress
      ..startTime = task.startTime?.millisecondsSinceEpoch
      ..endTime = task.endTime?.millisecondsSinceEpoch
      ..reminderTime = task.reminderTime?.millisecondsSinceEpoch
      ..subTasks = task.subTasks.map(IsarSubTask.fromDomain).toList();
  }
}
