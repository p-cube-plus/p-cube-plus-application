import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/utilities/error_message.dart';

class RestApi {
  RestApi._privateConstructor();
  static final RestApi _instance = RestApi._privateConstructor();
  static RestApi get instance => _instance;

  Future<http.Response> get(
      Uri url, Map<String, String> additionalHeader) async {
    var response = await http.get(url, headers: additionalHeader);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  Future<http.Response> post(Uri url, Map<String, String> header,
      {Object? body}) async {
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  Future<http.Response> put(Uri url, Map<String, String> header,
      {Object? body}) async {
    var response = await http.put(url, headers: header, body: body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  Future<http.Response> delete(Uri url, Map<String, String> header,
      {Object? body}) async {
    var response = await http.delete(url, headers: header, body: body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }
}
