import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:data/firebase/firebase_manager.dart';
import 'package:data/remote/common/header_builder.dart';
import 'package:data/remote/common/token_holder.dart';
import 'package:data/remote/p_cube_api/auth/response/auth_token_response_dto.dart';
import 'package:data/utils/json_util.dart';
import 'package:domain/common/exception/api_exception.dart';
import 'package:domain/common/exception/app_timeout_exception.dart';
import 'package:domain/common/exception/login_expired_exception.dart';
import 'package:domain/common/exception/refresh_token_exception.dart';
import 'package:http/http.dart' as http;

class PCubeApi with TokenHolder {
  static final PCubeApi _instance = PCubeApi._internal();
  PCubeApi._internal();
  factory PCubeApi() => _instance;

  final timeout = Duration(seconds: 5);
  Completer<void>? _refreshCompleter;

  final String _hostName = "p-cube-plus.com";
  Uri _getUri(String path, {Map<String, String>? queryParameters}) =>
      Uri.http(_hostName, path, queryParameters);

  Future<http.Response> get(String path,
      {Map<String, String>? headers,
      Map<String, String>? queryParameters}) async {
    return await _sendRequest(
      http.Request('GET', _getUri(path, queryParameters: queryParameters)),
      headers: headers,
    );
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async {
    return await _sendRequest(
      http.Request('POST', _getUri(path, queryParameters: queryParameters)),
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async {
    return await _sendRequest(
      http.Request('PUT', _getUri(path, queryParameters: queryParameters)),
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
  }) async {
    return await _sendRequest(
      http.Request('DELETE', _getUri(path, queryParameters: queryParameters)),
      headers: headers,
      body: body,
    );
  }

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
      }
    }

    try {
      log("http request: $request");
      var streamedResponse = await request.send().timeout(timeout);
      var response = await http.Response.fromStream(streamedResponse);
      log("http response: $response");

      if (response.statusCode == HttpStatus.ok) {
        return response;
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        await _resetToken();

        log("http 토큰 재발급 후 request: $request");
        streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        log("http 토큰 재발급 후 response: $response");

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
    } catch (e) {
      if (e is RefreshTokenException || e is LoginExpiredException) {
        rethrow;
      }

      if (e is TimeoutException) {
        FirebaseManager().sendFirebaseLog("FAILED_API_APP_TIMEOUT", {
          "mothodType": request.method,
          "inputUri": request.url.toString(),
          "inputHeader": request.headers.toString(),
          "inputBody": request.body,
          "error": "타임아웃 $timeout",
        });
        throw AppTimeoutException();
      } else if (e is ApiException) {
        final exception = e;
        FirebaseManager().sendFirebaseLog("FAILED_API", {
          "mothodType": exception.mothodType,
          "inputUri": exception.inputUri,
          "inputHeader": exception.inputHeader ?? "",
          "inputBody": exception.inputBody ?? "",
          "statusCode": exception.statusCode,
          "errorBody": exception.errorBody,
        });
        rethrow;
      } else {
        FirebaseManager().sendFirebaseLog("FAILED_API_UNKNOWN", {
          "error": e.toString(),
        });
        rethrow;
      }
    }
  }

  void _interceptHeader(http.Request request) {
    final isLoginApi = request.url.path.startsWith("/oauth");
    if (isLoginApi) return;

    final defaultHeader =
        HeaderBuilder().contentTypeJson().withToken(accessToken).build();

    request.headers.addAll(defaultHeader);
  }

  Future<void> _resetToken() async {
    if (_refreshCompleter != null) {
      log("Refresh Token 갱신 대기 중...");
      await _refreshCompleter!.future;
      return;
    }

    _refreshCompleter = Completer<void>();
    log("http 토큰 재발급 시도");

    FirebaseManager().sendFirebaseLog("REFRESH_TOKEN", {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    });

    try {
      final refreshTokenUri = _getUri("/auth/token/refresh");
      final refreshHeader =
          HeaderBuilder().contentTypeJson().withToken(refreshToken).build();

      final refreshResponse = await http
          .get(refreshTokenUri, headers: refreshHeader)
          .timeout(timeout);

      if (refreshResponse.statusCode == HttpStatus.ok) {
        final tokenData = JsonUtil().convertTo<AuthTokenResponseDTO>(
            AuthTokenResponseDTO.fromJson, refreshResponse.body);

        await setToken(tokenData.accessToken, tokenData.refreshToken);
        log("http 토큰 재발급 성공");

        FirebaseManager().sendFirebaseLog("SUCCESS_REFRESH_TOKEN", {
          "newAccessToken": tokenData.accessToken,
          "newRefreshToken": tokenData.refreshToken,
        });

        _refreshCompleter!.complete();
        _refreshCompleter = null;
        return;
      }

      log("http 토큰 재발급 실패");

      throw ApiException(
        mothodType: "GET",
        inputUri: refreshTokenUri.toString(),
        inputHeader: refreshHeader.toString(),
        inputBody: null,
        statusCode: refreshResponse.statusCode,
        errorBody: refreshResponse.body,
      );
    } catch (e) {
      _refreshCompleter!.completeError(e);
      _refreshCompleter = null;

      if (e is TimeoutException) {
        FirebaseManager().sendFirebaseLog("FAILED_REFRESH_TOKEN_APP_TIMEOUT", {
          "accessToken": accessToken,
          "refreshToken": refreshToken,
          "error": "타임아웃 $timeout",
        });
        throw RefreshTokenException();
      } else if (e is ApiException) {
        final exception = e;

        if (exception.statusCode == HttpStatus.unauthorized) {
          FirebaseManager()
              .sendFirebaseLog("FAILED_REFRESH_TOKEN_UNAUTHORIZED", {
            "accessToken": accessToken,
            "refreshToken": refreshToken,
          });
          throw LoginExpiredException();
        }

        FirebaseManager().sendFirebaseLog("FAILED_REFRESH_TOKEN", {
          "mothodType": exception.mothodType,
          "inputUri": exception.inputUri,
          "inputHeader": exception.inputHeader ?? "",
          "inputBody": exception.inputBody ?? "",
          "statusCode": exception.statusCode,
          "errorBody": exception.errorBody,
          "accessToken": accessToken,
          "refreshToken": refreshToken,
        });
        throw RefreshTokenException();
      } else {
        FirebaseManager().sendFirebaseLog("FAILED_REFRESH_TOKEN_UNKNOWN", {
          "accessToken": accessToken,
          "refreshToken": refreshToken,
          "error": "$e",
        });
        rethrow;
      }
    }
  }
}
