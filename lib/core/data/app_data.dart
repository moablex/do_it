import 'package:flutter/material.dart';

class AppData {
  static List<TaskCategory> get initialCategory => [
    TaskCategory(
      id: 'one',
      name: 'Work',
      icon: Icons.work,
      taskCount: 0,
      isSelected: true,
    ),
    TaskCategory(
      id: 'Three',
      name: 'Personal',
      icon: Icons.person,
      taskCount: 0,
    ),
    TaskCategory(
      id: 'Two',
      name: 'Shopping',
      icon: Icons.shopping_cart,
      taskCount: 0,
    ),
    TaskCategory(
      id: 'Four',
      name: 'Health',
      icon: Icons.health_and_safety,
      taskCount: 0,
    ),
    TaskCategory(
      id: 'Five',
      name: 'Education',
      icon: Icons.school,
      taskCount: 0,
    ),
    TaskCategory(
      id: 'Six',
      name: 'Finance',
      icon: Icons.payments,
      taskCount: 0,
    ),
    TaskCategory(id: 'Seven', name: 'None', icon: Icons.task, taskCount: 0),
  ];
  static const List<String> starterTags = [
    'Urgent',
    'Low',
    'Medium',
    'Quick',
    'Home',
    'Office',
  ];
}
//Task category class

class TaskCategory {
  final String id;
  final String name;
  final IconData icon;
  final taskCount;
  final isSelected;

  TaskCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.taskCount,
    this.isSelected = false,
  });
  TaskCategory copyWith({bool? isSelected}) {
    return TaskCategory(
      id: this.id,
      name: this.name,
      icon: this.icon,
      taskCount: this.taskCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
