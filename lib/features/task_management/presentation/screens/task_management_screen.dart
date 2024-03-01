import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_item_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_list_widget.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoTaskCubit>().getTasks();
    context.read<DoingTaskCubit>().getTasks();
    context.read<DoneTaskCubit>().getTasks();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Placeholder(
          child: DefaultTabController(
            length: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                      width: double.infinity,
                      height: 200,
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -22,
                      child: Placeholder(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: TabBar(
                                padding: EdgeInsets.all(8),
                                indicatorPadding: EdgeInsets.zero,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                tabAlignment: TabAlignment.start,
                                tabs: TaskStatus.values
                                    .map(
                                      (type) => Placeholder(
                                        child: Container(
                                          width: 64,
                                          height: 28,
                                          alignment: Alignment.center,
                                          child: Text(
                                            type.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<TodoTaskCubit, TaskManagementState>(
                        buildWhen: (previous, current) =>
                            previous.getTaskStatus != current.getTaskStatus,
                        builder: (context, state) {
                          switch (state.getTaskStatus) {
                            case ApiStatusType.loading || ApiStatusType.initial:
                              return const CircularProgressIndicator();
                            case ApiStatusType.error:
                              return const Text('Error');
                            case ApiStatusType.success:
                              return TaskListWidget(tasks: state.tasks);
                          }
                        },
                      ),
                      BlocBuilder<DoingTaskCubit, TaskManagementState>(
                        builder: (context, state) {
                          return TaskListWidget(tasks: state.tasks);
                        },
                      ),
                      BlocBuilder<DoneTaskCubit, TaskManagementState>(
                        builder: (context, state) {
                          return TaskListWidget(tasks: state.tasks);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Music'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Video'),
                    onTap: () => {},
                  ),
                ],
              ),
            );
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(64),
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
