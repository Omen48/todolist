import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/Task.dart';
import 'package:todolist/domain/entity/group.dart';

class BoxManager {
  static final BoxManager instanse = BoxManager._();

  BoxManager._();

  Future<Box<Group>> openGroupBox() async =>
      _openBox('group_box', 0, GroupAdapter());

  Future<Box<Task>> openTaskBox(int groupKey) async =>
      _openBox(makeTaskBoxName(groupKey), 1, TaskAdapter());

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  String makeTaskBoxName( int groupKey) => 'task_box_$groupKey';
  
  Future<Box<T>> _openBox<T>(
    String name,
    int typeID,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeID)) {
      Hive.registerAdapter(adapter);
    }
    return await Hive.openBox<T>(name);
  }
}
