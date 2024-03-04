import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/core/presentation/widgets/binding_observer_widget.dart';
import 'package:task_manage_management/features/core/presentation/widgets/error_dialog_widget.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_list_empty_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_list_skeleton_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_list_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_management_header_widget.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoTaskCubit>().getTasks();
    context.read<DoingTaskCubit>().getTasks();
    context.read<DoneTaskCubit>().getTasks();
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoTaskCubit, TaskManagementState>(
          listener: (context, state) {
            if (state.getTaskStatus == ApiStatusType.error) {
              showDialog<void>(
                context: context,
                builder: (_) => ErrorDialogWidget(
                  error: state.error ?? UnknownException(),
                ),
              );
            }
          },
        ),
        BlocListener<DoingTaskCubit, TaskManagementState>(
          listener: (context, state) {
            if (state.getTaskStatus == ApiStatusType.error) {
              showDialog<void>(
                context: context,
                builder: (_) => ErrorDialogWidget(
                  error: state.error ?? UnknownException(),
                ),
              );
            }
          },
        ),
        BlocListener<DoneTaskCubit, TaskManagementState>(
          listener: (context, state) {
            if (state.getTaskStatus == ApiStatusType.error) {
              showDialog<void>(
                context: context,
                builder: (_) => ErrorDialogWidget(
                  error: state.error ?? UnknownException(),
                ),
              );
            }
          },
        ),
      ],
      child: BindingObserverWidget(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Stack(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        BlocBuilder<TodoTaskCubit, TaskManagementState>(
                          builder: (context, state) {
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.initial) {
                              return const TaskListSkeletonWidget();
                            }
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.loading) {
                              return const TaskListSkeletonWidget();
                            } else if (state.getTaskStatus ==
                                ApiStatusType.error) {
                              return const TaskListEmptyWidget();
                            } else {
                              final tasksGroupByDate = context
                                  .read<TodoTaskCubit>()
                                  .groupTaskByDate(state.tasks);
                              return TaskListWidget(
                                tasksGroupByDateList: tasksGroupByDate,
                                onPaginate: () => context
                                    .read<TodoTaskCubit>()
                                    .getMoreTasks(),
                                onRefresh: () =>
                                    context.read<TodoTaskCubit>().getTasks(),
                              );
                            }
                          },
                        ),
                        BlocBuilder<DoingTaskCubit, TaskManagementState>(
                          builder: (context, state) {
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.initial) {
                              return const TaskListSkeletonWidget();
                            }
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.loading) {
                              return const TaskListSkeletonWidget();
                            } else if (state.getTaskStatus ==
                                ApiStatusType.error) {
                              return const TaskListEmptyWidget();
                            } else {
                              final tasksGroupByDate = context
                                  .read<DoingTaskCubit>()
                                  .groupTaskByDate(state.tasks);
                              return TaskListWidget(
                                tasksGroupByDateList: tasksGroupByDate,
                                onPaginate: () => context
                                    .read<DoingTaskCubit>()
                                    .getMoreTasks(),
                                onRefresh: () =>
                                    context.read<DoingTaskCubit>().getTasks(),
                              );
                            }
                          },
                        ),
                        BlocBuilder<DoneTaskCubit, TaskManagementState>(
                          builder: (context, state) {
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.initial) {
                              return const TaskListSkeletonWidget();
                            }
                            if (state.tasks.isEmpty &&
                                state.getTaskStatus == ApiStatusType.loading) {
                              return const TaskListSkeletonWidget();
                            } else if (state.getTaskStatus ==
                                ApiStatusType.error) {
                              return const TaskListEmptyWidget();
                            } else {
                              final tasksGroupByDate = context
                                  .read<DoneTaskCubit>()
                                  .groupTaskByDate(state.tasks);
                              return TaskListWidget(
                                tasksGroupByDateList: tasksGroupByDate,
                                onPaginate: () => context
                                    .read<DoneTaskCubit>()
                                    .getMoreTasks(),
                                onRefresh: () =>
                                    context.read<DoneTaskCubit>().getTasks(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const TaskManagementHeaderWidget(),
                ],
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: 36,
            height: 36,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.music_note),
                        title: const Text('Music'),
                        onTap: () => {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.videocam),
                        title: const Text('Video'),
                        onTap: () => {},
                      ),
                    ],
                  );
                },
              ),
              tooltip: 'Increment',
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(128),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
