import 'package:task_manage_management/features/task_management/data/data_sources/task_management_remote_data_source.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskManagementRepository {
  TaskManagementRepository(this.remoteDataSource);

  final TaskManagementRemoteDataSource remoteDataSource;

  Future<(List<Task>, int)> getTasks(TaskStatus status, int pageSize) async {
    final tasks = await remoteDataSource.getTasks(status, pageSize);
    return tasks;
  }

  // Future<Task> createTask(Task task) async {
  //   final createdTask = await remoteDataSource.createTask(task);
  //   return createdTask;
  // }

  // Future<Task> updateTask(Task task) async {
  //   final updatedTask = await remoteDataSource.updateTask(task);
  //   return updatedTask;
  // }

  // Future<void> deleteTask(String id) async {
  //   await remoteDataSource.deleteTask(id);
  // }
}
