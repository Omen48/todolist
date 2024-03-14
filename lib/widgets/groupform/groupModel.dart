import 'package:flutter/material.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/group.dart';

class GroupWidgetModel {
  var groupName = '';

  void saveGroup(BuildContext context) async {
    final box = await BoxManager.instanse.openGroupBox();
    await box.add(Group(name: groupName));
    await BoxManager.instanse.closeBox(box);

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
