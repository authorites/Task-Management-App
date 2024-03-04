import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/main_injector_container.dart';

class MainMultiBlocProvider extends StatelessWidget {
  const MainMultiBlocProvider({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TodoTaskCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DoingTaskCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DoneTaskCubit>(),
        ),
      ],
      child: child,
    );
  }
}
