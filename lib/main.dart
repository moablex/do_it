import 'package:do_it/features/todo/data/models/Isar_todo.dart';
import 'package:do_it/features/todo/data/repositories/isar_todo_repo.dart';
import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:do_it/features/todo/presentation/block/todo_cubit.dart';
import 'package:do_it/features/todo/presentation/screens/home_screen.dart';
import 'package:do_it/features/todo/presentation/widgets/Navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize the database once
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([IsarTaskSchema], directory: dir.path);
  final repository = IsarTodoRepo(isar);
  runApp(MyApp(todoRepo: repository));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepo;
  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        todoRepository: todoRepo,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.todoRepository,
  });

  final String title;
  final TodoRepository todoRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepository),
      child: NavigationWrapper(),
      //bottomNavigationBar: TodoBottomNavBar(todoRepo: todoRepository),
      //body: Center(child: Text("data")),
      // body: SafeArea(child: const HomeScreen()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NavigationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext contet) {
    return const TodoBottomNavBar();
  }
}
