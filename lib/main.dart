import 'package:do_it/features/todo/data/models/Isar_todo.dart';
import 'package:do_it/features/todo/data/repositories/isar_todo_repo.dart';
import 'package:do_it/features/todo/domain/repository/todo_repository.dart';
import 'package:do_it/features/todo/presentation/screens/home_screen.dart';
import 'package:do_it/features/todo/presentation/widgets/Navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<TodoRepository> repositoryInit = _initializeDatabase();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<TodoRepository>(
        future: repositoryInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return MyHomePage(
                title: 'Flutter Demo Home Page',
                todoRepository: snapshot.data!,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading database: ${snapshot.error}'),
              );
            }
            // Show a loading indicator while waiting for the database
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.teal)),
          );
        },
      ),
    );
  }

  //Data base initialization
  Future<TodoRepository> _initializeDatabase() async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open([IsarTaskSchema], directory: dir.path);
    // Instantiate and return the repository implementation
    return IsarTodoRepo(isar);
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
    return Scaffold(
      bottomNavigationBar: TodoBottomNavBar(todoRepo: todoRepository),
      //body: Center(child: Text("data")),
      // body: SafeArea(child: const HomeScreen()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
