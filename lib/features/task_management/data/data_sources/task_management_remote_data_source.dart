import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/network_http.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskManagementRemoteDataSource {
  TaskManagementRemoteDataSource(this.http);
  final NetworkHttp http;

  Future<List<Task>> getTasks(
    TaskStatus status,
    int pageSize,
    int pageNumber,
  ) async {
    NetworkResponse response;
    try {
      response = await http.get(
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=$pageNumber&limit=$pageSize&sortBy=createdAt&isAsc=true&status=${status.value}',
      );
      if (response.statusCode != 200) throw ServerException();
    } catch (_) {
      rethrow;
    }
    try {
      final tasksJson = json.decode(response.body) as Map;
      final tasksList =
          List<Map<String, dynamic>>.from(tasksJson['tasks'] as List);
      final tasks = tasksList.map(Task.fromJson).toList();
      return tasks;
    } catch (e) {
      debugPrint(e.toString());
      throw FormatException(e.toString());
    }
  }

  Future<Task> createTask(Task task) async {
    // TODO(Amnard): Implement createTask
    throw UnimplementedError();
  }

  Future<Task> deleteTask(String id) async {
    // TODO(Amnard): Implement deleteTask
    throw UnimplementedError();
  }
}
