import 'dart:convert';

import 'package:p_cube_plus_application/models/warning.dart';

import 'base/pcube_api.dart';

class WarningApi extends PCubeApi {
  WarningApi({int? id}) : super(endPoint: "/warning");

  @override
  Future<Warning> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => Warning.fromJson(jsonDecode(body)),
    );
  }
}
