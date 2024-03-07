import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/Task.dart';

import '../../domain/entity/group.dart';

class TaskWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  Group? _group;

  Group? get group => _group;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  TaskWidgetModel({required this.groupKey}) {
    _setup();
  }

  void _readTask() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _setupListenableBox() async {
    final box = await _groupBox;
    _readTask();
    box.listenable(keys: [groupKey]).addListener(_readTask);
  }

  void deleteTask(int groupIndex) {
    _group?.tasks?.deleteFromHive(groupIndex);
    _group?.save();
  }

  void switchToggle(int groupIndex) async {
    final task = _group?.tasks?[groupIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('group_box');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    _loadGroup();
    _setupListenableBox();
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
