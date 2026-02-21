import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:do_it/features/todo/presentation/block/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  //Reference the TODO repo
  final TodoRepository todoRepo;
  //constructor to initialize cubit with an empty list
  TodoCubit(this.todoRepo) : super(TodoLoading()) {
    loadTOdos();
  }
  //Load todos
  Future<void> loadTOdos() async {
    try {
      final todos = await todoRepo.getTask();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError('Failed to load tasks !'));
    }
  }
  //ADD todos

  Future<void> addTask(Task task) async {
    try {
      await todoRepo.addTask(task);
      emit(TodoAdditionSuccess('Task Successfully saved ! '));
      final todos = await todoRepo.getTask();

      emit(
        TodoLoaded(todos: todos, successMessage: "Task added successfully!"),
      );
    } catch (e) {
      emit(TodoError('Failed to add tasks !'));
    }
  }

  //Update task
  Future<void> updateTask(Task updatedTask) async {
    try {
      //Persist updated task
      await todoRepo.updateTask(updatedTask);
      await todoRepo.addTask(updatedTask);
      final todos = await todoRepo.getTask();
      emit(
        TodoLoaded(todos: todos, successMessage: "Task Updated successfully!"),
      );
    } catch (e) {
      emit(TodoError('Failed to add tasks !'));
    }
  }

  //Delete Task
  Future<void> deleteTask(Task task) async {
    try {
      //Delete todos from the repository
      await todoRepo.deleteTask(task);

      final todos = await todoRepo.getTask();
      emit(
        TodoLoaded(todos: todos, successMessage: "Task Deleted successfully!"),
      );
    } catch (e) {
      emit(TodoError('Failed to Delete tasks !'));
    }
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
