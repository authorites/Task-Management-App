import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manage_management/features/task_management/domain/entities/tasks_group_by_date.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_group_by_date_widget.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({
    required this.tasksGroupByDateList,
    required this.onPaginate,
    required this.onRefresh,
    super.key,
  });
  final List<TasksGroupByDate> tasksGroupByDateList;
  final VoidCallback onPaginate;
  final VoidCallback onRefresh;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent * 0.8) {
        widget.onPaginate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      edgeOffset: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.tasksGroupByDateList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return const Gap(200);
            final tasksGroup = widget.tasksGroupByDateList[index - 1];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TaskGroupByDateWidget(
                groupDate: tasksGroup.date,
                tasks: tasksGroup.tasks,
              ),
            );
          },
        ),
      ),
    );
  }
}
