import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/Task.dart';
import 'package:todolist/domain/entity/group.dart';

class BoxManager {
  static final BoxManager instanse = BoxManager._();
  final Map<String, int> _boxOpenCloseCounter = <String, int>{};

  BoxManager._();

  Future<Box<Group>> openGroupBox() async =>
      _openBox('group_box', 0, GroupAdapter());

  Future<Box<Task>> openTaskBox(int groupKey) async =>
      _openBox(makeTaskBoxName(groupKey), 1, TaskAdapter());

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxOpenCloseCounter.remove(box.name);
      return;
    }
    var count = _boxOpenCloseCounter[box.name] ?? 1;
    count -= 1;
    _boxOpenCloseCounter[box.name] = count;
    if (count > 0) return;
    _boxOpenCloseCounter.remove(box.name);
    await box.compact();
    await box.close();
  }

  String makeTaskBoxName(int groupKey) => 'task_box_$groupKey';

  Future<Box<T>> _openBox<T>(
    String name,
    int typeID,
    TypeAdapter<T> adapter,
  ) async {
    if (Hive.isBoxOpen(name)) {
      final counter = _boxOpenCloseCounter[name] ?? 1;
      _boxOpenCloseCounter[name] = counter + 1;
      return Hive.box(name);
    }
    _boxOpenCloseCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeID)) {
      Hive.registerAdapter(adapter);
    }
    return await Hive.openBox<T>(name);
  }
}
