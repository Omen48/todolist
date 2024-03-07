import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/Task.dart';
import 'package:todolist/domain/entity/group.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskName = '';

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('task_box');
    final task = Task(name: taskName, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('group_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);

    // await box.add(Group(name: taskName));
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
