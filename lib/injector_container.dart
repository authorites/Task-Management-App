import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:task_manage_management/core/network/network_info.dart';
import 'package:task_manage_management/features/task_management/task_management_injector_container.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    //* Core
    ..registerLazySingleton(() => NetworkInfo(getIt()))

    //* External
    // final sharedPreferences = await SharedPreferences.getInstance();
    // ..registerLazySingleton(() => sharedPreferences);
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(Connectivity.new);

  //* Features
  TaskManagementInjectorContainer.setup();
}
