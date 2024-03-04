import 'package:flutter/widgets.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/avatar_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_management_title_box_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/widgets/task_tab_bar_widget.dart';

class TaskManagementHeaderWidget extends StatelessWidget {
  const TaskManagementHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        TaskManagementTitleBoxWidget(),
        Positioned(
          top: 8,
          right: 8,
          child: AvatarWidget(),
        ),
        Positioned(
          child: TaskTabBarWidget(),
        ),
      ],
    );
  }
}
