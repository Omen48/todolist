import 'package:flutter/material.dart';
import 'package:todolist/internal/main_navigation/main_navigator.dart';
import 'package:todolist/widgets/example/example.dart';

class MyApp extends StatelessWidget {
  static final navigation = MainNavigation();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: navigation.routes,
      initialRoute: navigation.initialroute,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: navigation.onGenerateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Examp(),
    );
  }
}
