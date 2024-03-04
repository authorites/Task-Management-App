import 'package:http/http.dart' as http;
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/network_info.dart';
import 'package:task_manage_management/main_injector_container.dart';

class NetworkHttp {
  http.Client get client => _client ??= http.Client();

  http.Client? _client;

  Future<NetworkResponse> get(
    String url, {
    Map<String, String> headers = const {},
  }) async {
    try {
      if (!await getIt<NetworkInfo>().isConnected) throw NoInternetException();
      final response = await client.get(
        Uri.parse(url),
        headers: headers,
      );
      return NetworkResponse(response.statusCode, response.body);
    } on NoInternetException {
      rethrow;
    } catch (_) {
      throw NetworkHttpException();
    }
  }
}

class NetworkResponse {
  NetworkResponse(this.statusCode, this.body);

  final int statusCode;
  final String body;
}
