import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manage_management/core/network/network_http.dart';
import 'package:task_manage_management/core/network/network_info.dart';
import 'package:task_manage_management/features/passcode/passcode_injector_container.dart';
import 'package:task_manage_management/features/task_management/task_management_injector_container.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    //* Core
    ..registerLazySingleton(() => NetworkInfo(getIt()))

    //* External
    ..registerLazySingleton(NetworkHttp.new)
    ..registerLazySingleton(Connectivity.new);

  //* Features
  TaskManagementInjectorContainer.setup();
  PasscodeInjectorContainer.setup();
}
