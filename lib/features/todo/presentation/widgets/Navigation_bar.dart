import 'package:do_it/features/todo/presentation/screens/Add_Task.dart';
import 'package:do_it/features/todo/presentation/screens/Task_History.dart';
import 'package:do_it/features/todo/presentation/screens/home_screen.dart';
import 'package:do_it/features/todo/presentation/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class TodoBottomNavBar extends StatefulWidget {
  TodoBottomNavBar({super.key});

  @override
  State<TodoBottomNavBar> createState() => _TodoBottomNavBarState();
}

class _TodoBottomNavBarState extends State<TodoBottomNavBar> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
      initialIndex: 0,
    ); // Start on the first tab
  }

  List<Widget> _buidScreen() {
    return [const HomeScreen(), const AddTask(), TaskHistory(), Settings()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(icon: Icon(Icons.home)),
      PersistentBottomNavBarItem(icon: Icon(Icons.add)),
      PersistentBottomNavBarItem(icon: Icon(Icons.history)),
      PersistentBottomNavBarItem(icon: Icon(Icons.settings)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buidScreen(),
      items: _navBarsItems(),
    );
  }
}
