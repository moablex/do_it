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
    this.startTime,
    this.endTime,
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
