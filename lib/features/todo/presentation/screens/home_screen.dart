import 'package:do_it/features/todo/presentation/widgets/task_list.dart';
import 'package:flutter/material.dart';
import '../widgets/search_task.dart';
import '../widgets/Task_categories.dart';
import '../../../../core/data/app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskCategory> taskCategories = AppData.initialCategory;
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
