import 'dart:convert';

extension StringExtensions on String {
  List convertToJsonList() {
    return jsonDecode(this) as List;
  }
}