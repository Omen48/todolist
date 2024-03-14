import 'package:flutter/material.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/group.dart';

class GroupWidgetModel extends ChangeNotifier {
  var _groupName = '';
  String? errorText;

  set groupName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  void saveGroup(BuildContext context) async {
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText = 'Введите название группы';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instanse.openGroupBox();
    await box.add(Group(name: groupName));
    await BoxManager.instanse.closeBox(box);
  }
}

class GroupWidgetModelProvider extends InheritedNotifier {
  final GroupWidgetModel model;

  const GroupWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child, notifier: model );

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
  bool updateShouldNotify(GroupWidgetModelProvider oldWidget) {
    return true;
  }
}
