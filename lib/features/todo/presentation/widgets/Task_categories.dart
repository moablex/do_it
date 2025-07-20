import 'package:flutter/material.dart';

class TaskCategoryScroll extends StatelessWidget {
  final List<TaskCategory> categories;
  final Function(String) onCategorySelected;

  const TaskCategoryScroll({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0,
              right: index == categories.length - 1 ? 16.0 : 8.0,
            ),
            child: CategoryCard(
              category: category,
              onTap: () => onCategorySelected(category.name),
            ),
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final TaskCategory category;
  final VoidCallback onTap;

  const CategoryCard({Key? key, required this.category, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                category.isSelected
                    ? [Colors.blue.shade400, Colors.blue.shade600]
                    : [Colors.grey.shade200, Colors.grey.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 32,
              color: category.isSelected ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    category.isSelected ? Colors.white : Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${category.taskCount} tasks',
              style: TextStyle(
                fontSize: 12,
                color:
                    category.isSelected ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCategory {
  final String name;
  final IconData icon;
  final int taskCount;
  final bool isSelected;

  TaskCategory({
    required this.name,
    required this.icon,
    required this.taskCount,
    this.isSelected = false,
  });
}
