import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:do_it/features/todo/presentation/block/todo_cubit.dart';
import 'package:do_it/features/todo/presentation/screens/Add_Task.dart';
import 'package:do_it/features/todo/presentation/screens/Task_History.dart';
import 'package:do_it/features/todo/presentation/screens/home_screen.dart';
import 'package:do_it/features/todo/presentation/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBottomNavBar extends StatefulWidget {
  const TodoBottomNavBar({super.key});

  @override
  State<TodoBottomNavBar> createState() => _TodoBottomNavBarState();
}

class _TodoBottomNavBarState extends State<TodoBottomNavBar> {
  int _currentIndex = 0;

  List<Widget> _screens = const [];
  @override
  void initState() {
    super.initState();
    //  Initialize the screens
    _screens = [
      const HomeScreen(),
      //  Pass the callback function to AddTask
      AddTask(
        onTaskAdded: () {
          _onTabTapped(0); // Switch to Home index when a task is added
        },
      ),
      const TaskHistory(),
      const Settings(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _currentIndex != 1
              ? FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
