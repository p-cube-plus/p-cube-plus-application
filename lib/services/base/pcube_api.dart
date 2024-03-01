import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/utilities/error_message.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

const String _baseUrl = "http://p-cube-plus.com";

class PCubeApi {
  PCubeApi({required this.endPoint, this.isExternalApi = false});

  final String endPoint;
  final bool isExternalApi;

  Uri _getUrl() => Uri.parse(_baseUrl + endPoint);

  Future<Map<String, String>> _getHeader(
      Map<String, String>? additionalHeader) async {
    var headers = {
      "Content-Type": "application/json",
    };
    if (!isExternalApi) {
      String? token = await TokenManager().getAccessToken();
      if (kDebugMode) {
        token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcwODE2NjE2MiwianRpIjoiZDBlYjE2NTgtOTQzNC00MjM2LWFkZmQtMDRhM2EyOTExNzBiIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InRlc3QiLCJuYmYiOjE3MDgxNjYxNjIsImV4cCI6MTcxMDc1ODE2Mn0.Sc1gWSjuIyYYuis_qOfG_jXtBVRcQj87coZ3N0XSaQo";
      }

      headers.addAll({"Authorization": "Bearer ${token}"});
    }
    if (additionalHeader != null) {
      headers.addAll(additionalHeader);
    }
    return headers;
  }

  get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    var response = await http.get(
        _getUrl().replace(queryParameters: queryParams),
        headers: await _getHeader(additionalHeader));

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  post(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.post(_getUrl(),
        headers: await _getHeader(additionalHeader),
        body: jsonEncode(body),
        encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  put(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.put(_getUrl(),
        headers: await _getHeader(additionalHeader),
        body: body,
        encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  delete(
      {Function(http.Response response)? decodeFsuccessReturnFunctionnction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.delete(_getUrl(),
        headers: await _getHeader(additionalHeader),
        body: body,
        encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return decodeFsuccessReturnFunctionnction!(response);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }
}
