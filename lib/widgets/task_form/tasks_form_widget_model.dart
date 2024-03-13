import 'package:flutter/material.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/Task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskName = '';

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final box = await BoxManager.instanse.openTaskBox(groupKey);
    final task = Task(name: taskName, isDone: false);
     box.add(task);
     // await BoxManager.instanse.closeBox(box);
  }
}

class TaskFormWidgetModelProvider extends InheritedWidget {
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child);

  static TaskFormWidgetModelProvider watch(BuildContext context) {
    final TaskFormWidgetModelProvider? result = context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
    assert(result != null, 'No GroupWidgetModelProvider found in context');
    return result!;
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return result is TaskFormWidgetModelProvider ? result : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider old) {
    return false;
  }
}
