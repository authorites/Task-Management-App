import 'package:task_manage_management/features/task_management/data/data_sources/task_management_remote_data_source.dart';
import 'package:task_manage_management/features/task_management/data/repositories/task_management_repository.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/main_injector_container.dart';

class TaskManagementInjectorContainer {
  static void setup() {
    getIt
      ..registerFactory(() => TodoTaskCubit(repository: getIt()))
      ..registerFactory(() => DoingTaskCubit(repository: getIt()))
      ..registerFactory(() => DoneTaskCubit(repository: getIt()))
      ..registerFactory(() => TaskManagementRepository(getIt()))
      ..registerFactory(() => TaskManagementRemoteDataSource(getIt()));
  }
}
