import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';
import '../widgets/search_task.dart';
import '../widgets/Task_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('Home')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchTask(),
          SizedBox(height: 15),
          TaskCategoryScroll(
            categories: [
              TaskCategory(
                name: 'Work',
                icon: Icons.work,
                taskCount: 5,
                isSelected: true,
              ),
              TaskCategory(name: 'Personal', icon: Icons.person, taskCount: 3),
              TaskCategory(
                name: 'Shopping',
                icon: Icons.shopping_cart,
                taskCount: 2,
              ),
              TaskCategory(name: 'Health', icon: Icons.favorite, taskCount: 4),
            ],
            onCategorySelected: (category) {
              print('Selected category: $category');
            },
          ),
          TaskList(),
        ],
      ),
    );
  }
}
