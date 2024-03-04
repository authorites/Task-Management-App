import 'package:equatable/equatable.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TasksGroupByDate extends Equatable {
  const TasksGroupByDate({
    required this.date,
    required this.tasks,
  });

  final DateTime date;
  final List<Task> tasks;

  @override
  List<Object?> get props => [
        date,
        tasks,
      ];
}
