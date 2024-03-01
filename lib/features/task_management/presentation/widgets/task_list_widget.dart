import 'package:flutter/material.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    required this.tasks,
    super.key,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: tasks
              .map(
                (task) => TaskItemWidget(task: task),
              )
              .toList(),
        ),
      ),
    );
  }
}
