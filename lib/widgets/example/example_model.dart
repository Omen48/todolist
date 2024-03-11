import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/group.dart';

class ExampleModel extends ChangeNotifier {
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  ExampleModel() {
    getGroups();
  }

  void readBox(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void deleteGroup(int groupIndex) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    box.deleteAt(groupIndex);
  }

  void getGroups() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    readBox(box);

    box.listenable().addListener(() => readBox(box));
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleModel model;

  const ExampleModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(child: child, notifier: model);

  static ExampleModelProvider watch(BuildContext context) {
    final ExampleModelProvider? result =
        context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
    assert(result != null, 'No ExampleModelProvider found in context');
    return result!;
  }

  static ExampleModelProvider? read(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return result is ExampleModelProvider ? result : null;
  }
}
