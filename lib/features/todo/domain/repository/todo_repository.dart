/*
To Do Repository
*/
import 'package:do_it/features/todo/domain/models/todo.dart';

abstract class TodoRepository {
  //get list of tasks

  Future<List<Task>> getTask();

  //create new task

  Future<void> addTask(Task task);

  //Update the existing task

  Future<void> updateTask(Task task);

  //Delete task

  Future<void> deleteTask(Task task);
}
