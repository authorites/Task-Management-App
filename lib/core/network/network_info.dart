import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo(this.connectionChecker);

  final Connectivity connectionChecker;

  Future<bool> get isConnected async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
