import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/widgets/task_form/tasks_form_widget.dart';
import 'package:todolist/widgets/tasks/tasks_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TaskWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final args = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskWidgetModel(groupKey: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TaskWidgetModelProvider(
        model: model,
        child: const TaskBodyWidget(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TaskBodyWidget extends StatelessWidget {
  const TaskBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context).model;
    final title = model.group?.name ?? 'Задачи';
    return Scaffold(
      body: const Center(
        child: TasksList(),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => showDialog(
                routeSettings: RouteSettings(
                    name: 'Передача groupKey',
                    arguments:
                        ModalRoute.of(context)!.settings.arguments as int),
                context: context,
                builder: (context) => const TaskFormWidget(),
              ),
          child: const Icon(Icons.add)),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
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
