import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';
import '../widgets/search_task.dart';
import '../widgets/Task_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskCategory> taskCategories = [
    TaskCategory(
      id: 'one',
      name: 'Work',
      icon: Icons.work,
      taskCount: 5,
      isSelected: true,
    ),
    TaskCategory(
      id: 'Three',
      name: 'Personal',
      icon: Icons.person,
      taskCount: 3,
    ),
    TaskCategory(
      id: 'Two',
      name: 'Shopping',
      icon: Icons.shopping_cart,
      taskCount: 2,
    ),
    TaskCategory(
      id: 'Four',
      name: 'Health',
      icon: Icons.favorite,
      taskCount: 4,
    ),
  ];
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
            categories: taskCategories,
            onCategorySelected: (categoryId) {
              setState(() {
                taskCategories =
                    taskCategories.map((category) {
                      return category.copyWith(
                        isSelected: category.id == categoryId,
                      );
                    }).toList();
              });
            },
          ),
          TaskList(),
        ],
      ),
    );
  }
}
