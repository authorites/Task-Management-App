import 'package:flutter/material.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskTabBarWidget extends StatelessWidget {
  const TaskTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            labelColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            indicatorWeight: 0,
            dividerHeight: 0,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            tabAlignment: TabAlignment.start,
            tabs: TaskStatus.values
                .map(
                  (type) => Container(
                    width: 56,
                    height: 32,
                    alignment: Alignment.center,
                    child: Tab(
                      text: type.name,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
