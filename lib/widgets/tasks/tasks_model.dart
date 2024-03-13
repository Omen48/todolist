import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/Task.dart';
import 'package:todolist/widgets/tasks/tasks.dart';

class TaskWidgetModel extends ChangeNotifier {
   TaskWidgetConfig configuration;
   ValueListenable<Object>? _listener;

   late final Future<Box<Task>> _box;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  TaskWidgetModel({required this.configuration}) {
    _setup();
  }

  Future<void> deleteTask(int taskIndex) async {
    (await _box).deleteAt(taskIndex);
  }

  void switchToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
    // notifyListeners();
  }

  Future<void> _readTaskFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instanse.openTaskBox(configuration.groupKey);

    await _readTaskFromHive();
    _listener =(await _box).listenable();
    _listener?.addListener(_readTaskFromHive);
  }

  @override
  Future<void> dispose() async {
    _listener?.removeListener(_readTaskFromHive);
    await BoxManager.instanse.closeBox((await _box));
        super.dispose();
  }

}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;

  const TaskWidgetModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(child: child, notifier: model);

  static TaskWidgetModelProvider watch(BuildContext context) {
    final TaskWidgetModelProvider? result =
        context.dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
    assert(result != null, 'No ExampleModelProvider found in context');
    return result!;
  }

  static TaskWidgetModelProvider? read(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<TaskWidgetModelProvider>()
        ?.widget;
    return result is TaskWidgetModelProvider ? result : null;
  }
}
