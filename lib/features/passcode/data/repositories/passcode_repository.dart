import 'package:task_manage_management/features/passcode/data/data_sources/passcode_remote_data_source.dart';

class PasscodeRepository {
  PasscodeRepository(this.dataSource);

  final PasscodeRemoteDataSource dataSource;

  Future<bool> setPasscode(String passcode) async {
    return dataSource.setPasscode(passcode);
  }

  Future<bool> checkPasscode(String passcode) async {
    return dataSource.checkPasscode(passcode);
  }
}
