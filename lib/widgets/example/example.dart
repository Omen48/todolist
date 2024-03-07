import 'package:flutter/material.dart';

class Examp extends StatelessWidget {
  const Examp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Группы'),
      ),
      body: SafeArea(child: GroupList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
    return const ListTile(
      title: Text('data'),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
