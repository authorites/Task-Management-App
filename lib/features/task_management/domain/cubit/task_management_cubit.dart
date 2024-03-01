import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/task_management/data/repositories/task_management_repository.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

part 'task_management_state.dart';

const int pageSize = 20;

sealed class TaskManagementCubit extends Cubit<TaskManagementState> {
  TaskManagementCubit({
    required this.taskType,
    required this.repository,
  }) : super(const TaskManagementState());

  final TaskStatus taskType;
  final TaskManagementRepository repository;

  Future<void> getTasks() async {
    if (state.getTaskStatus == ApiStatusType.loading) return;
    if (state.hasAllData) return;
    emit(state.copyWith(getTaskStatus: ApiStatusType.loading));
    try {
      final (tasks, totalPages) = await repository.getTasks(taskType, pageSize);
      emit(
        state.copyWith(
          getTaskStatus: ApiStatusType.success,
          tasks: tasks,
          todoTaskPageNumber: state.todoTaskPageNumber + 1,
          hasAllData: totalPages < pageSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getTaskStatus: ApiStatusType.error));
    }
  }

  @override
  void onChange(Change<TaskManagementState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
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
