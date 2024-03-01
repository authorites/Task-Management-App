import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/network_info.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';
import 'package:task_manage_management/injector_container.dart';

class TaskManagementRemoteDataSource {
  TaskManagementRemoteDataSource(this.client);
  final http.Client client;

  Future<(List<Task>, int)> getTasks(TaskStatus status, int pageSize) async {
    http.Response response;
    try {
      if (!await getIt<NetworkInfo>().isConnected) throw NoInternetException();
      response = await client.get(
        Uri.parse(
          'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=$pageSize&sortBy=createdAt&isAsc=true&status=${status.value}',
        ),
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
      // final pageNumber = tasksJson['pageNumber'] as int;
      final totalPages = tasksJson['totalPages'] as int;
      return (
        tasks,
        totalPages,
      );
    } catch (e) {
      debugPrint(e.toString());
      throw FormatException(e.toString());
    }
  }

  // Future<Task> createTask(Task task) async {
  //   final response = await client.post(
  //     Uri.parse('https://jsonplaceholder.typicode.com/todos'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: json.encode(task.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     final Map<String, dynamic> taskJson = json.decode(response.body);
  //     return Task.fromJson(taskJson);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // Future<Task> updateTask(Task task) async {
  //   final response = await client.put(
  //     Uri.parse('https://jsonplaceholder.typicode.com/todos/${task.id}'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: json.encode(task.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> taskJson = json.decode(response.body);
  //     return Task.fromJson(taskJson);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // Future<void> deleteTask(String id) async {
  //   final response = await client.delete(
  //     Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }
}
