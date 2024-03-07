import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/domain/entity/group.dart';

class GroupWidgetModel {
  var groupName = '';

  void saveGroup(BuildContext context) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    await box.add(Group(name: groupName));
  }
}

class GroupWidgetModelProvider extends InheritedWidget {
  final GroupWidgetModel model;

  const GroupWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child);

  static GroupWidgetModelProvider watch(BuildContext context) {
    final GroupWidgetModelProvider? result =
        context.dependOnInheritedWidgetOfExactType<GroupWidgetModelProvider>();
    assert(result != null, 'No GroupWidgetModelProvider found in context');
    return result!;
  }

  static GroupWidgetModelProvider? read(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<GroupWidgetModelProvider>()
        ?.widget;
    return result is GroupWidgetModelProvider ? result : null;
  }

  @override
  bool updateShouldNotify(GroupWidgetModelProvider old) {
    return true;
  }
}
