import 'dart:convert';

class JsonUtil {
  JsonUtil._internal();
  static final JsonUtil _instance = JsonUtil._internal();
  factory JsonUtil() => _instance;

  T convertTo<T>(T Function(Map<String, dynamic> map) fromJson, String json) {
    return fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  List<T> convertToList<T>(
      T Function(Map<String, dynamic> map) fromJson, String json) {
    return (jsonDecode(json) as List)
        .map<T>((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
