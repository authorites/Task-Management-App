import 'package:task_manage_management/core/network/network_http.dart';

class PasscodeRemoteDataSource {
  PasscodeRemoteDataSource(this.http);

  final NetworkHttp http;

  Future<bool> checkPasscode(String passcode) async {
    // TODO(Amnard): implement checkPasscode
    return passcode == '123456';
  }

  Future<bool> setPasscode(String passcode) async {
    // TODO(Amnard): implement savePasscode
    return true;
  }
}
