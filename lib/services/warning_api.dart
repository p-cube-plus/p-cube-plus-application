import 'package:p_cube_plus_application/models/warning.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/project.dart';
import 'base/pcube_api.dart';

class WarningApi extends PCubeApi {
  WarningApi({int? id}) : super(endPoint: "/warning");

  @override
  Future<Warning?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => Warning.fromJson(jsonDecodeData),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<Warning?> getWarningList() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}
