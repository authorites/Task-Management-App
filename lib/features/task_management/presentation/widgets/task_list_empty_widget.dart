import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskListEmptyWidget extends StatelessWidget {
  const TaskListEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_rounded,
            color: Theme.of(context).colorScheme.secondary,
            size: 100,
          ),
          const Gap(16),
          Text(
            'empty task list',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
