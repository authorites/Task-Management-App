import 'package:task_manage_management/features/task_management/data/data_sources/task_management_remote_data_source.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskManagementRepository {
  TaskManagementRepository(this.remoteDataSource);

  final TaskManagementRemoteDataSource remoteDataSource;

  Future<List<Task>> getTasks(
    TaskStatus status,
    int pageSize,
    int pageNumber,
  ) async {
    return remoteDataSource.getTasks(
      status,
      pageSize,
      pageNumber,
    );
  }

  Future<Task> createTask(Task task) async {
    return remoteDataSource.createTask(task);
  }

  Future<Task> deleteTask(String id) async {
    return remoteDataSource.deleteTask(id);
  }
}
