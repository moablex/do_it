/*
Database repository

This implements domain/repository/todo_repository.dart

It handles creating,retrieving , updating and deliting tasks in the isar databse


 */

import 'package:do_it/features/todo/data/models/Isar_todo.dart';
import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:isar/isar.dart';

class IsarTodoRepo implements TodoRepository {
  final Isar db;
  IsarTodoRepo(this.db);

  //get tasks
  @override
  Future<List<Task>> getTask() async {
    final allTasks = await db.collection<IsarTask>().where().findAll();
    return allTasks.map((task) => task.toDomain()).toList();
  }

  //create tasks
  @override
  Future<void> addTask(Task task) async {
    // First convert task model in to isar task
    final isarTask = await IsarTask.fromDomain(task);
    return db.writeTxn(() => db.collection<IsarTask>().put(isarTask));
  }

  //update tasks
  @override
  Future<void> updateTask(Task task) async {
    final isarTask = await IsarTask.fromDomain(task);
    return db.writeTxn(() => db.collection<IsarTask>().put(isarTask));
  }

  //delete tasks
  @override
  Future<void> deleteTask(Task task) async {
    final taskToDelete =
        await db.collection<IsarTask>().filter().idEqualTo(task.id).findFirst();
    if (taskToDelete != null) {
      await db.writeTxn(
        () => db.collection<IsarTask>().delete(taskToDelete.isarId!),
      );
    }
  }
}
