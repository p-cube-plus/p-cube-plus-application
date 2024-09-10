import 'dart:convert';

import 'package:domain/exception/api_exception.dart';
import 'package:http/http.dart' as http;
import 'header_builder.dart';

class PCubeApi {
  final Uri _uri;

  PCubeApi(String endPoint)
      : _uri = Uri.parse("http://p-cube-plus.com/$endPoint");

  Future<http.Response> get({Map<String, String>? headers}) async =>
      _sendRequest(
        http.Request('GET', _uri),
        headers ?? HeaderBuilder().contentTypeJson().withToken().build(),
        null,
      );

  Future<http.Response> post({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('POST', _uri),
        headers ?? HeaderBuilder().contentTypeJson().withToken().build(),
        body,
      );

  Future<http.Response> put({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('PUT', _uri),
        headers ?? HeaderBuilder().contentTypeJson().withToken().build(),
        body,
      );

  Future<http.Response> delete({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('DELETE', _uri),
        headers ?? HeaderBuilder().contentTypeJson().withToken().build(),
        body,
      );

  Future<http.Response> _sendRequest(
    http.Request request,
    Map<String, String> headers,
    Object? body,
  ) async {
    headers.addAll(headers);
    if (body != null) request.body = jsonEncode(body);

    print(request);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print(response);

    if (response.statusCode == 200) return response;

    if (response.statusCode == 401) {
      // TODO: 토큰 재요청
    }

    throw ApiException(
      mothodType: request.method,
      inputUri: request.url.toString(),
      inputHeader: request.headers.toString(),
      inputBody: request.body,
      statusCode: response.statusCode,
      errorBody: response.body,
    );
  }
}
