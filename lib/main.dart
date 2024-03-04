import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/bloc/bloc_observer.dart';
import 'package:task_manage_management/features/core/presentation/screens/splash_screen.dart';
import 'package:task_manage_management/main_injector_container.dart'
    as dependency_injector;
import 'package:task_manage_management/main_multi_bloc_provider.dart';

void main() {
  dependency_injector.setup();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainMultiBlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            tertiary: Color.fromRGBO(151, 194, 253, 1.0),
            secondaryContainer: Color.fromRGBO(224, 223, 228, 1.0),
            primary: Color.fromRGBO(145, 167, 255, 1.0),
            background: Color.fromRGBO(234, 237, 255, 1.0),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
