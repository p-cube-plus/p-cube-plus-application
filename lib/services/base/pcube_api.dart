import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/utilities/error_message.dart';

const String _baseUrl = "http://p-cube-plus.com";

class PCubeApi {
  PCubeApi({required this.endPoint});
  final String endPoint;

  IErrorMessage _errorMessage = new UnknownError();
  String get errorMessage => _errorMessage.message;

  get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    var response = await http.get(
        Uri.parse(_baseUrl + endPoint).replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      try {
        return decodeFunction!(json.decode(response.body));
      } catch (e) {
        throw Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw Exception(FailedToGetServerData().message);
    }
  }

  post(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.post(Uri.parse(_baseUrl + endPoint),
        headers: headers, body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return decodeFunction!(json.decode(response.body));
      } catch (e) {
        _errorMessage = new FailedToConvertJSONData();
      }
    } else {
      _errorMessage = new FailedToGetServerData();
    }
    return null;
  }

  put(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.put(Uri.parse(_baseUrl + endPoint),
        headers: headers, body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return decodeFunction!(json.decode(response.body));
      } catch (e) {
        _errorMessage = new FailedToConvertJSONData();
      }
    } else {
      _errorMessage = new FailedToGetServerData();
    }
    return null;
  }

  delete(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.delete(Uri.parse(_baseUrl + endPoint),
        headers: headers, body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return decodeFunction!(json.decode(response.body));
      } catch (e) {
        _errorMessage = new FailedToConvertJSONData();
      }
    } else {
      _errorMessage = new FailedToGetServerData();
    }
    return null;
  }
}
