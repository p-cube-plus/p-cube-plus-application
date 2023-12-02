import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/project.dart';
import 'base/pcube_api.dart';

class ProjectApi extends PCubeApi {
  ProjectApi({int? id}) : super(endPoint: "/project");

  @override
  Future<List<Project>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) =>
          jsonDecodeData.map((e) => Project.fromJson(e)).toList(),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<List<Project>?> getProjects() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}
