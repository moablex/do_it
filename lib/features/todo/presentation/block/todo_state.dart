import 'package:do_it/features/todo/domain/models/todo.dart';

abstract class TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Task> todos;
  String? successMessage;
  TodoLoaded({required this.todos, this.successMessage});
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
