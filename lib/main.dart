import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manage_management/core/bloc/bloc_observer.dart';
import 'package:task_manage_management/features/task_management/domain/cubit/task_management_cubit.dart';
import 'package:task_manage_management/features/task_management/presentation/screens/task_management_screen.dart';
import 'package:task_manage_management/injector_container.dart'
    as dependency_injector;
import 'package:task_manage_management/injector_container.dart';

void main() {
  dependency_injector.setup();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(anmard): set router.
    // TODO(anmard): set theme.
    // TODO(anmard): set localizations.
    // TODO(amnard): set navigator.
    // TODO(amnard): set home.
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
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('en'),
        //   Locale('th'),
        // ],
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    super.key,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  DateTime? lastPausedTime;
  Timer? inactivityTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // startInactivityTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inactivityTimer?.cancel();
    super.dispose();
  }

  void startInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(const Duration(seconds: 10), () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PasscodeScreen()),
      // );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        lastPausedTime = DateTime.now();
      case AppLifecycleState.resumed:
        if (lastPausedTime != null &&
            DateTime.now().difference(lastPausedTime!).inSeconds > 10) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PasscodeScreen()),
          // );
        }
        startInactivityTimer();
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const TaskManagementScreen(),
      ),
    );
    // setState(() {
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
