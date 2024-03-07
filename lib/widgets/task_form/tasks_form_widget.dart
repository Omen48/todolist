import 'package:flutter/material.dart';
import 'package:todolist/widgets/task_form/tasks_form_widget_model.dart';

//
// class TasksFormWidget extends StatelessWidget {
//   const TasksFormWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final args = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(model: _model!, child: const TaskForm());
  }
}

class TaskForm extends StatelessWidget {
  const TaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            TaskFormWidgetModelProvider.read(context)?.model.saveTask(context);
            Navigator.of(context).pop();
          },
          child: const Text('Добавить задачу'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
      ],
      elevation: 24.0,
      content: TextField(
        expands: true,
        maxLines: null,
        minLines: null,
        autofocus: true,
        onEditingComplete: () {
          TaskFormWidgetModelProvider.read(context)?.model.saveTask(context);
          Navigator.of(context).pop();
        },
        onChanged: (value) =>
            TaskFormWidgetModelProvider.read(context)?.model.taskName = value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
      title: const Text('Добавить новую задачу'),
    );
  }
}
