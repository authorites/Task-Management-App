import 'package:task_manage_management/features/passcode/data/data_sources/passcode_remote_data_source.dart';
import 'package:task_manage_management/features/passcode/data/repositories/passcode_repository.dart';
import 'package:task_manage_management/features/passcode/domain/cubit/passcode_cubit.dart';
import 'package:task_manage_management/main_injector_container.dart';

class PasscodeInjectorContainer {
  static void setup() {
    getIt
      ..registerFactory(() => PasscodeCubit(repository: getIt()))
      ..registerFactory(() => PasscodeRepository(getIt()))
      ..registerFactory(() => PasscodeRemoteDataSource(getIt()));
  }
}
