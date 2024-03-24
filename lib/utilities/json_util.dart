import 'dart:convert';

import 'package:http/http.dart';

class JsonUtil {
  JsonUtil._privateConstructor();
  static final JsonUtil _instance = JsonUtil._privateConstructor();
  static JsonUtil get instance => _instance;

  T convertTo<T>(T Function(Map<String, dynamic> map) fromJson, String json) {
    return fromJson((jsonDecode(json) as Map).cast());
  }

  List<T> convertToList<T>(
      T Function(Map<String, dynamic> map) fromJson, String json) {
    return (jsonDecode(json) as List)
        .map((e) => fromJson((e as Map).cast()))
        .toList();
  }

  T convertToWithHeader<T>(
      T Function(Map<String, dynamic> header, Map<String, dynamic> body)
          fromJson,
      Response response) {
    return fromJson(
        response.headers, (jsonDecode(response.body) as Map).cast());
  }
}
