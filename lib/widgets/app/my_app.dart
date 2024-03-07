import 'package:flutter/material.dart';
import 'package:todolist/widgets/example/example.dart';
import 'package:todolist/widgets/tasks/tasks.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/tasks': (BuildContext context) => const TasksWidget(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Examp(),
    );
  }
}
