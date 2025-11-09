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
    //save the new task to the repository
    await todoRepo.addTask(task);
    //Reload
    loadTOdos();
  }

  //Update task
  Future<void> updateTask(Task updatedTask) async {
    //Persist updated task
    await todoRepo.updateTask(updatedTask);

    //Reload to update the UI
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
  Future<void> toggleCompleted(Task task) async {
    task.toggleCompleted();
    task.progress = task.calculateProgress();
    //update the todo repo with the toggle status
    await todoRepo.updateTask(task);
    //Reload
    loadTOdos();
  }
}
