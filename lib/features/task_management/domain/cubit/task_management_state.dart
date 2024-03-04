part of 'task_management_cubit.dart';

class TaskManagementState extends Equatable {
  const TaskManagementState({
    this.getTaskStatus = ApiStatusType.initial,
    this.deleteTaskStatus = ApiStatusType.initial,
    this.tasks = const [],
    this.todoTaskPageNumber = 0,
    this.hasAllData = false,
    this.error,
  });

  final ApiStatusType getTaskStatus;
  final ApiStatusType deleteTaskStatus;
  final List<Task> tasks;
  final int todoTaskPageNumber;
  final bool hasAllData;
  final Exception? error;

  TaskManagementState copyWith({
    ApiStatusType? getTaskStatus,
    ApiStatusType? deleteTaskStatus,
    List<Task>? tasks,
    int? todoTaskPageNumber,
    bool? hasAllData,
    Exception? Function()? error,
  }) {
    return TaskManagementState(
      getTaskStatus: getTaskStatus ?? this.getTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      tasks: tasks ?? this.tasks,
      todoTaskPageNumber: todoTaskPageNumber ?? this.todoTaskPageNumber,
      hasAllData: hasAllData ?? this.hasAllData,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        getTaskStatus,
        deleteTaskStatus,
        tasks,
        todoTaskPageNumber,
        hasAllData,
        error,
      ];
}
