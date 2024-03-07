import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/widgets/groupform/groupFrom.dart';

class Examp extends StatelessWidget {
  const Examp({super.key});

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
          showDialog(context: context, builder: (_) => GroupForm());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
        itemBuilder: (context, index) => RowOfGroup(indexGroup: index),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: 25,
      ),
    );
  }
}

class RowOfGroup extends StatelessWidget {
  final int indexGroup;

  const RowOfGroup({super.key, required this.indexGroup});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (context) => () {},
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (context) => () {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: const ListTile(
        title: Text('data'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
