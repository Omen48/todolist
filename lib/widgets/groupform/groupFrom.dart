import 'package:flutter/material.dart';
import 'package:todolist/widgets/groupform/groupModel.dart';


class GroupWidget extends StatefulWidget {
  const GroupWidget({super.key});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  final _model = GroupWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(model: _model,
    child: const GroupForm());
  }
}


class GroupForm extends StatelessWidget {
  const GroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            GroupWidgetModelProvider.read(context)?.model.saveGroup(context);
            Navigator.of(context).pop();
          },
          child: const Text('Добавить новую группу'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
      ],
      elevation: 24.0,
      content:  TextField(
        autofocus: true,
        onEditingComplete: () {
          GroupWidgetModelProvider.read(context)?.model.saveGroup(context);
          Navigator.of(context).pop();
        },
        onChanged:(value) => GroupWidgetModelProvider.read(context)?.model.groupName = value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
      title: const Text('Добавить новую группу'),
    );
  }
}
