import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/common/models/StatusCode.dart';
import 'package:p_cube_plus_application/remote/http/header_builder.dart';
import 'package:p_cube_plus_application/remote/services/token_service.dart';
import 'package:p_cube_plus_application/remote/utils/token_manager.dart';

class PCubeApi {
  final Uri _url;
  PCubeApi(String endPoint)
      : _url = Uri.parse("http://p-cube-plus.com/$endPoint");

  Future<http.Response> get({Map<String, String>? headers}) async =>
      _sendRequest(() => http.get(_url, headers: _getHeaders(headers)));

  Future<http.Response> post({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
          () => http.post(_url, headers: _getHeaders(headers), body: body));

  Future<http.Response> put({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
          () => http.put(_url, headers: _getHeaders(headers), body: body));

  Future<http.Response> delete({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
          () => http.delete(_url, headers: _getHeaders(headers), body: body));

  Map<String, String> _getHeaders(Map<String, String>? headers) {
    return headers ?? HeaderBuilder().contentTypeJson().withToken().build();
  }

  Future<http.Response> _sendRequest(
      Future<http.Response> Function() request) async {
    var response = await request();
    if (StatusCode.get(response.statusCode) == StatusCode.Unauthorized) {
      var refreshResponse = await TokenService().getRefreshedToken();
      var tokenManager = TokenManager();
      await tokenManager.saveToken(
          refreshResponse.accessToken, refreshResponse.refreshToken);
      response = await request();
    }
    return response;
  }
}
