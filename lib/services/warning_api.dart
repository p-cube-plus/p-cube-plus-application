import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/models/warning.dart';

import 'base/pcube_api.dart';

class WarningApi extends PCubeApi {
  WarningApi() : super(endPoint: "/warning");

  @override
  Future<Warning> get(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (response) =>
          Warning.fromJson(jsonDecode(response.body)),
    );
  }
}
