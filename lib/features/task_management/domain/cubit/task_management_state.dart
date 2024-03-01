part of 'task_management_cubit.dart';

class TaskManagementState extends Equatable {
  const TaskManagementState({
    this.getTaskStatus = ApiStatusType.initial,
    this.tasks = const [],
    this.todoTaskPageNumber = 0,
    this.hasAllData = false,
  });

  final ApiStatusType getTaskStatus;
  final List<Task> tasks;
  final int todoTaskPageNumber;
  final bool hasAllData;

  TaskManagementState copyWith({
    ApiStatusType? getTaskStatus,
    List<Task>? tasks,
    int? todoTaskPageNumber,
    bool? hasAllData,
  }) {
    return TaskManagementState(
      getTaskStatus: getTaskStatus ?? this.getTaskStatus,
      tasks: tasks ?? this.tasks,
      todoTaskPageNumber: todoTaskPageNumber ?? this.todoTaskPageNumber,
      hasAllData: hasAllData ?? this.hasAllData,
    );
  }

  @override
  List<Object> get props => [
        getTaskStatus,
        tasks,
        todoTaskPageNumber,
        hasAllData,
      ];
}
