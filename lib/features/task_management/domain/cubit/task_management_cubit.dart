import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/task_management/data/repositories/task_management_repository.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';
import 'package:task_manage_management/features/task_management/domain/entities/tasks_group_by_date.dart';

part 'task_management_state.dart';

const int pageSize = 10;

sealed class TaskManagementCubit extends Cubit<TaskManagementState> {
  TaskManagementCubit({
    required this.taskType,
    required this.repository,
  }) : super(const TaskManagementState());

  final TaskStatus taskType;
  final TaskManagementRepository repository;

  List<TasksGroupByDate> groupTaskByDate(List<Task> tasks) {
    final groupByDateList = <TasksGroupByDate>[];
    for (final task in tasks) {
      final index = groupByDateList.indexWhere(
        (group) => DateUtils.isSameDay(group.date, task.createdAt),
      );
      if (index == -1) {
        groupByDateList.add(
          TasksGroupByDate(
            date: task.createdAt,
            tasks: [task],
          ),
        );
      } else {
        groupByDateList[index].tasks.add(task);
      }
    }
    groupByDateList.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    return groupByDateList;
  }

  Future<void> getTasks() async {
    if (state.getTaskStatus == ApiStatusType.loading) return;
    emit(
      state.copyWith(
        getTaskStatus: ApiStatusType.loading,
        tasks: [],
      ),
    );
    try {
      final tasks = await repository.getTasks(
        taskType,
        pageSize,
        0,
      );
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.success,
          tasks: tasks,
          todoTaskPageNumber: 1,
          hasAllData: tasks.length < pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.error,
          error: () => e is Exception ? e : UnknownException(),
        ),
      );
    }
  }

  Future<void> getMoreTasks() async {
    if (state.hasAllData) return;
    if (state.getTaskStatus == ApiStatusType.loading) return;
    emit(state.copyWith(getTaskStatus: ApiStatusType.loading));
    try {
      final tasks = await repository.getTasks(
        taskType,
        pageSize,
        state.todoTaskPageNumber,
      );
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.success,
          tasks: [...state.tasks, ...tasks],
          todoTaskPageNumber: state.todoTaskPageNumber + 1,
          hasAllData: tasks.length < pageSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.error,
          error: () => e is Exception ? e : UnknownException(),
        ),
      );
    }
  }

  Future<void> deleteTask(String taskId) async {
    emit(state.copyWith(deleteTaskStatus: ApiStatusType.loading));
    try {
      //final task =  await repository.deleteTask(taskId);
      final tasks = state.tasks.where((task) => task.id != taskId).toList();
      emit(
        state.copyWith(
          deleteTaskStatus: ApiStatusType.success,
          tasks: tasks,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.error,
          error: () => e is Exception ? e : UnknownException(),
        ),
      );
    }
  }
}

class TodoTaskCubit extends TaskManagementCubit {
  TodoTaskCubit({
    required super.repository,
    super.taskType = TaskStatus.todo,
  });
}

class DoingTaskCubit extends TaskManagementCubit {
  DoingTaskCubit({
    required super.repository,
    super.taskType = TaskStatus.doing,
  });
}

class DoneTaskCubit extends TaskManagementCubit {
  DoneTaskCubit({
    required super.repository,
    super.taskType = TaskStatus.done,
  });
}
