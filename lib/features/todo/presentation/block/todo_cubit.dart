import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<Task>> {
  //Reference the TODO repo
  final TodoRepository todoRepo;
  //constructor to initialize cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTOdos();
  }
  //Load todos
  Future<void> loadTOdos() async {
    final todos = await todoRepo.getTask();
    emit(todos);
  }
  //ADD todos

  Future<void> addTask(Task task) async {
    final newTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: false,
      subTasks: task.subTasks,
      tags: task.tags,
      startTime: task.startTime ?? DateTime.now(),
      endTime: task.endTime,
      progress: 0.0,
      reminderTime: task.reminderTime,
    );
    //save the new task to the repository
    await todoRepo.addTask(newTask);
    //Reload
    loadTOdos();
  }

  //Delete Task
  Future<void> deleteTask(Task task) async {
    //Delete todos from the repository
    await todoRepo.deleteTask(task);
    //Reload
    loadTOdos();
  }

  //Toggle task
  Future<void> toggleCompleted(task) async {
    task.toggleCompleted();
    task.progress = task.calculateProgress();
    //update the todo repo with the toggle status
    await todoRepo.updateTask(task);
    //Reload
    loadTOdos();
  }
}
