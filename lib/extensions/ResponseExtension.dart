
import 'dart:convert';

import 'package:http/http.dart';

extension ResponseExtensions<T> on Response {
  T convertTo<T>() {
    return jsonDecode(this.body);
  }
}