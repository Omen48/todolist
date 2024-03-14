import 'package:flutter/material.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/Task.dart';

class TaskFormWidgetModel extends ChangeNotifier{
  int groupKey;
  String? errorText;
  var _taskName = '';

  set taskName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _taskName = value;
  }


  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskName = _taskName.trim();
    if (taskName.isEmpty) {
      errorText = 'Введите название задачи';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instanse.openTaskBox(groupKey);
    final task = Task(name: taskName, isDone: false);
    box.add(task);
    await BoxManager.instanse.closeBox(box);
  }
}

class TaskFormWidgetModelProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child, notifier: model);

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
