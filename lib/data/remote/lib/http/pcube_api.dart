import 'package:data/models/remote/error/error_dto.dart';
import 'package:data/utils/json_util.dart';
import 'package:http/http.dart' as http;

import 'header_builder.dart';

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
      Future<http.Response> Function() requestFunction) async {
    var response = await requestFunction();
    if (response.statusCode == 200) return response;

    var error =
        JsonUtil().convertTo<ErrorDto>(ErrorDto.fromJson, response.body);

    var errorCode = error.errorCode ?? -1;
    var errorType = error.errorType ?? "";
    throw Exception("$_url ($errorCode): $errorType");
  }
}
