import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/core/network/network_http.dart';
import 'package:task_manage_management/features/task_management/data/data_sources/task_management_remote_data_source.dart';
import 'package:task_manage_management/features/task_management/data/repositories/task_management_repository.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class MockNetworkHttp extends Mock implements NetworkHttp {}

void main() {
  late NetworkHttp mockNetworkHttp;
  late TaskManagementRemoteDataSource dataSource;
  late TaskManagementRepository repository;

  setUp(() {
    mockNetworkHttp = MockNetworkHttp();
    dataSource = TaskManagementRemoteDataSource(mockNetworkHttp);
    repository = TaskManagementRepository(dataSource);
  });

  group('TodoManagementCubit', () {
    group('error case', () {
      final error = NetworkHttpException();
      blocTest<TaskManagementCubit, TaskManagementState>(
        'when something wrong happens, should return error state and catch exception',
        build: () => TodoTaskCubit(repository: repository),
        setUp: () => when(() => mockNetworkHttp.get(any())).thenThrow(error),
        act: (cubit) => cubit.getTasks(),
        expect: () => <TaskManagementState>[
          const TaskManagementState(getTaskStatus: ApiStatusType.loading),
          TaskManagementState(
            getTaskStatus: ApiStatusType.error,
            error: error,
          ),
        ],
      );
    });
    group('normal case', () {
      blocTest<TaskManagementCubit, TaskManagementState>(
        'when getTasks is called, should get task list',
        build: () => TodoTaskCubit(repository: repository),
        setUp: () => when(() => mockNetworkHttp.get(any())).thenAnswer(
          (_) async => NetworkResponse(
            200,
            File('test/features/task_management/tasks.json').readAsStringSync(),
          ),
        ),
        act: (cubit) => cubit.getTasks(),
        expect: () => <TaskManagementState>[
          const TaskManagementState(getTaskStatus: ApiStatusType.loading),
          TaskManagementState(
            getTaskStatus: ApiStatusType.success,
            hasAllData: true,
            todoTaskPageNumber: 1,
            tasks: [
              Task(
                id: 'cbb0732a-c9ab-4855-b66f-786cd41a3cd1',
                title: 'Read a book',
                description: 'Spend an hour reading a book for pleasure',
                createdAt: DateTime.parse('2023-03-24T19:30:00Z'),
                status: TaskStatus.todo,
              ),
              Task(
                id: '119a8c45-3f3d-41da-88bb-423c5367b81a',
                title: 'Exercise',
                description: 'Go for a run or do a workout at home',
                createdAt: DateTime.parse('2023-03-25T09:00:00Z'),
                status: TaskStatus.todo,
              ),
            ],
          ),
        ],
      );

      blocTest<TaskManagementCubit, TaskManagementState>(
        'when getMoreTasks is called, should append new task to exit task',
        build: () => TodoTaskCubit(repository: repository),
        setUp: () => when(() => mockNetworkHttp.get(any())).thenAnswer(
          (_) async => NetworkResponse(
            200,
            File('test/features/task_management/tasks.json').readAsStringSync(),
          ),
        ),
        seed: () => TaskManagementState(
          getTaskStatus: ApiStatusType.success,
          todoTaskPageNumber: 1,
          tasks: [
            Task(
              id: '1',
              status: TaskStatus.todo,
              createdAt: DateTime.parse('2023-03-24T19:30:00Z'),
            ),
          ],
        ),
        act: (cubit) => cubit.getMoreTasks(),
        expect: () => <TaskManagementState>[
          TaskManagementState(
            getTaskStatus: ApiStatusType.loading,
            todoTaskPageNumber: 1,
            tasks: [
              Task(
                id: '1',
                status: TaskStatus.todo,
                createdAt: DateTime.parse('2023-03-24T19:30:00Z'),
              ),
            ],
          ),
          TaskManagementState(
            getTaskStatus: ApiStatusType.success,
            hasAllData: true,
            todoTaskPageNumber: 2,
            tasks: [
              Task(
                id: '1',
                status: TaskStatus.todo,
                createdAt: DateTime.parse('2023-03-24T19:30:00Z'),
              ),
              Task(
                id: 'cbb0732a-c9ab-4855-b66f-786cd41a3cd1',
                title: 'Read a book',
                description: 'Spend an hour reading a book for pleasure',
                createdAt: DateTime.parse('2023-03-24T19:30:00Z'),
                status: TaskStatus.todo,
              ),
              Task(
                id: '119a8c45-3f3d-41da-88bb-423c5367b81a',
                title: 'Exercise',
                description: 'Go for a run or do a workout at home',
                createdAt: DateTime.parse('2023-03-25T09:00:00Z'),
                status: TaskStatus.todo,
              ),
            ],
          ),
        ],
      );
    });
  });
}
