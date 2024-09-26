import 'dart:io';

import 'package:data/remote/common/header_builder.dart';
import 'package:data/remote/common/token_holder.dart';
import 'package:data/remote/p_cube_api/auth/response/auth_token_response_dto.dart';
import 'package:data/utils/json_util.dart';
import 'package:domain/exception/api_exception.dart';
import 'package:http/http.dart' as http;

class PCubeApi with TokenHolder {
  static final PCubeApi _instance = PCubeApi._internal();
  PCubeApi._internal();
  factory PCubeApi() => _instance;

  final String hostName = "p-cube-plus.com";
  Uri _getUri(String path, {Map<String, String>? queryParameters}) =>
      Uri.http(hostName, path, queryParameters);

  Future<http.Response> get(String path,
          {Map<String, String>? headers,
          Map<String, String>? queryParameters}) async =>
      _sendRequest(
        http.Request('GET', _getUri(path, queryParameters: queryParameters)),
        headers: headers,
      );

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('POST', _getUri(path, queryParameters: queryParameters)),
        headers: headers,
        body: body,
      );

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('PUT', _getUri(path, queryParameters: queryParameters)),
        headers: headers,
        body: body,
      );

  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async =>
      _sendRequest(
        http.Request('DELETE', _getUri(path, queryParameters: queryParameters)),
        headers: headers,
        body: body,
      );

  Future<http.Response> _sendRequest(
    http.Request request, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    _interceptHeader(request);
    if (headers != null) request.headers.addAll(headers);

    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    print("http request: $request");
    var streamedResponse = await request.send().timeout(Duration(seconds: 10));
    var response = await http.Response.fromStream(streamedResponse);
    print("http response: $response");

    if (response.statusCode == HttpStatus.ok) {
      return response;
    }

    if (response.statusCode == HttpStatus.unauthorized) {
      _resetToken();

      print("http 토큰 재발급 후 request: $request");
      streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
      print("http 토큰 재발급 후 response: $response");

      if (response.statusCode == HttpStatus.ok) return response;
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

  void _interceptHeader(http.Request request) {
    final isLoginApi = request.url.path.startsWith("/oauth");
    if (isLoginApi) return;

    final defaultHeader =
        HeaderBuilder().contentTypeJson().withToken(accessToken).build();

    request.headers.addAll(defaultHeader);
  }

  Future<void> _resetToken() async {
    print("http 토큰 재발급 시도");

    Uri refreshTokenUri = _getUri("/auth/token/refresh");
    Map<String, String> refreshheaders = {
      "Content-Type": "application/json",
      "Authorization": refreshToken,
    };

    var refreshResponse =
        await http.get(refreshTokenUri, headers: refreshheaders);

    if (refreshResponse.statusCode == HttpStatus.ok) {
      var tokenData = JsonUtil().convertTo<AuthTokenResponseDTO>(
          AuthTokenResponseDTO.fromJson, refreshResponse.body);

      setToken(tokenData.accessToken, tokenData.refreshToken);
      print("http 토큰 재발급 성공");
      return;
    }

    print("http 토큰 재발급 실패");
    throw ApiException(
      mothodType: "GET",
      inputUri: refreshTokenUri.toString(),
      inputHeader: refreshheaders.toString(),
      inputBody: null,
      statusCode: refreshResponse.statusCode,
      errorBody: refreshResponse.body,
    );
  }
}
