import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manage_management/features/passcode/domain/cubit/passcode_cubit.dart';
import 'package:task_manage_management/features/passcode/presentation/screens/passcode_screen.dart';
import 'package:task_manage_management/main_injector_container.dart';

class MockPasscodeCubit extends Mock implements PasscodeCubit {}

void main() {
  final mockPasscodeCubit = MockPasscodeCubit();
  getIt.registerFactory<PasscodeCubit>(() => mockPasscodeCubit);
  when(() => mockPasscodeCubit.state).thenReturn(const PasscodeState());

  testGoldens('passcode screen', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.iphone11,
        ],
      )
      ..addScenario(
        widget: MaterialApp(
          debugShowCheckedModeBanner: false,
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
          home: BlocProvider(
            create: (context) => getIt<PasscodeCubit>(),
            child: PasscodeScreen(),
          ),
        ),
        name: 'default page',
      );

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'passcode_screen');
  });
}
