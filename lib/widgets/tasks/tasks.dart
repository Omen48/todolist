import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/widgets/task_form/tasks_form_widget.dart';
import 'package:todolist/widgets/tasks/tasks_model.dart';

class TaskWidgetConfig {
  final String title;
  final int groupKey;

  TaskWidgetConfig(this.title, this.groupKey);
}

class TasksWidget extends StatefulWidget {
  final TaskWidgetConfig configuration;

  const TasksWidget({super.key, required this.configuration});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TaskWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskWidgetModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return TaskWidgetModelProvider(
      model: _model,
      child: const TaskBodyWidget(),
    );
  }

  @override
  void dispose() {
      _model.dispose();
    super.dispose();
  }
}

class TaskBodyWidget extends StatelessWidget {
  const TaskBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context).model;
     return Scaffold(
      body: const Center(
        child: TasksList(),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => showDialog(
                context: context,
                builder: (context) => TaskFormWidget(
                  groupKey: model.configuration.groupKey,
                ),
              ),
          child: const Icon(Icons.add)),
      appBar: AppBar(
        centerTitle: true,
        title: Text(model.configuration.title),
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCount = TaskWidgetModelProvider.watch(context).model.tasks.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
        itemBuilder: (context, index) => RowOfTask(indexTask: index),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: taskCount,
      ),
    );
  }
}

class RowOfTask extends StatelessWidget {
  final int indexTask;

  const RowOfTask({super.key, required this.indexTask});

  @override
  Widget build(BuildContext context) {
    final taskName =
        TaskWidgetModelProvider.read(context)!.model.tasks[indexTask];

    final icon = taskName.isDone ? Icons.done : Icons.notifications_active;
    final style = taskName.isDone
        ? const TextStyle(decoration: TextDecoration.lineThrough)
        : null;

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => TaskWidgetModelProvider.read(context)!
                .model
                .deleteTask(indexTask),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(taskName.name, style: style),
        trailing: Icon(icon),
        onTap: () => TaskWidgetModelProvider.read(context)!
            .model
            .switchToggle(indexTask),
      ),
    );
  }
}
