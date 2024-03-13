import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/box_manager/box_manager.dart';
import 'package:todolist/domain/entity/group.dart';
import 'package:todolist/internal/main_navigation/main_navigator.dart';
import 'package:todolist/widgets/tasks/tasks.dart';

class ExampleModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  ValueListenable<Object>? _listener;
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  ExampleModel() {
    _setup();
  }

  Future<void> showTasks(BuildContext context, int groupIndex) async {
    final group = (await _box).getAt(groupIndex);
    if (group != null) {
      final configuration = TaskWidgetConfig(group.name , group.key as int);
      Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.tasks, arguments: configuration);
    }
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await BoxManager.instanse.openGroupBox();
    final groupKey = (await _box).keyAt(groupIndex) as int;
    await Hive.deleteBoxFromDisk(BoxManager.instanse.makeTaskBoxName(groupKey));
    box.deleteAt(groupIndex);
  }

  Future<void> _readBoxFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instanse.openGroupBox();

    await _readBoxFromHive();
    _listener = (await _box).listenable();
     _listener?.addListener(_readBoxFromHive);
  }
  
  @override
  Future<void> dispose() async{
    _listener?.removeListener(_readBoxFromHive);
    await BoxManager.instanse.closeBox((await _box));
    super.dispose();
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
