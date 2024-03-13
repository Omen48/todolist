import 'package:flutter/material.dart';
import 'package:todolist/widgets/example/example.dart';
import 'package:todolist/widgets/tasks/tasks.dart';

interface class MainNavigationRouteNames {
  static const groups = 'groups';
  static const tasks = 'groups/tasks';
}

class MainNavigation {
  final initialroute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (BuildContext context) => const Examp(),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final configuration = settings.arguments as TaskWidgetConfig;
    return MaterialPageRoute(
        builder: (context) => TasksWidget(
              configuration: configuration,
            ));
  }
}
