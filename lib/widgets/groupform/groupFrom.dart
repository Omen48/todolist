import 'package:flutter/material.dart';

class GroupForm extends StatelessWidget {
  const GroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Добавить новую группу'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Отмена'),
        ),
      ],
      elevation: 24.0,
      content: const TextField(
        decoration: InputDecoration(
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
