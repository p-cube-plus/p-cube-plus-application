import 'dart:convert';

import 'package:http/http.dart';

class ApiUtil {
  ApiUtil._privateConstructor();
  static final ApiUtil _instance = ApiUtil._privateConstructor();
  static ApiUtil get instance => _instance;

  Uri getUrl(String baseUrl, String endPoint,
      {Map<String, String>? queryParams}) {
    var _url = baseUrl + endPoint;
    if ((queryParams?.length ?? 0) == 0) return Uri.parse(_url);
    return Uri.parse(_getUrlWithQueryParams(_url, queryParams!));
  }

  _getUrlWithQueryParams(String currentUrl, Map<String, String> queryParams) {
    currentUrl += "?";
    for (String key in queryParams.keys) {
      var value = queryParams[key];
      currentUrl += "$key=$value&";
    }
    return currentUrl.substring(0, currentUrl.length - 1);
  }

  T convertTo<T>(
      T Function(Map<String, dynamic> map) fromJson, Response response) {
    return fromJson((jsonDecode(response.body) as Map).cast());
  }

  T convertToWithHeader<T>(
      T Function(Map<String, dynamic> header, Map<String, dynamic> body)
          fromJson,
      Response response) {
    return fromJson(
        response.headers, (jsonDecode(response.body) as Map).cast());
  }

  List<T> convertToList<T>(
      T Function(Map<String, dynamic> map) fromJson, String response) {
    return (jsonDecode(response) as List)
        .map((e) => fromJson((e as Map).cast()))
        .toList();
  }
}
