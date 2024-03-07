import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/widgets/example/example_model.dart';
import 'package:todolist/widgets/groupform/groupFrom.dart';

class Examp extends StatefulWidget {
  const Examp({super.key});

  @override
  State<Examp> createState() => _ExampState();
}

class _ExampState extends State<Examp> {
  final _model = ExampleModel();

  @override
  Widget build(BuildContext context) {
    return ExampleModelProvider(
      model: _model,
      child: GroupsBody(),
    );
  }
}

class GroupsBody extends StatelessWidget {
  const GroupsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Группы'),
      ),
      body: const SafeArea(child: GroupList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => GroupWidget());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final groupCount = ExampleModelProvider.watch(context).model.groups.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
        itemBuilder: (context, index) => RowOfGroup(indexGroup: index),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: groupCount,
      ),
    );
  }
}

class RowOfGroup extends StatelessWidget {
  final int indexGroup;

  const RowOfGroup({super.key, required this.indexGroup});

  @override
  Widget build(BuildContext context) {
    final groupname =
        ExampleModelProvider.read(context)!.model.groups[indexGroup];
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => ExampleModelProvider.read(context)!
                .model
                .deleteGroup(indexGroup),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(groupname.name),
        trailing: Icon(Icons.chevron_right),
        onTap: () => ExampleModelProvider.read(context)!
            .model
            .showTasks(context, indexGroup),
      ),
    );
  }
}
