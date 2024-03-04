import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_item_widget.dart';

class TaskGroupByDateWidget extends StatelessWidget {
  const TaskGroupByDateWidget({
    required this.groupDate,
    required this.tasks,
    super.key,
  });

  final DateTime groupDate;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('d MMMM yyyy').format(groupDate),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ...tasks.map(
          (task) => Dismissible(
            key: Key(task.id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('delete'),
                ),
              );
            },
            background: const ColoredBox(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TaskItemWidget(task: task),
            ),
          ),
        ),
      ],
    );
  }
}
