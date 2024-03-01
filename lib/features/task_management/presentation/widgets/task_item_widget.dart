import 'package:flutter/material.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Row(
        children: [
          Icon(Icons.directions_car),
          Expanded(
            child: Text(
              task.title,
              overflow: TextOverflow.clip,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
