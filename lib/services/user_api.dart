import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/user/user_profile.dart';
import 'base/pcube_api.dart';

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  @override
  Future<UserProfile?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => UserProfile.fromJson(jsonDecodeData),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<UserProfile?> getProfileInfo() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}

class UserProjectApi extends PCubeApi {
  UserProjectApi() : super(endPoint: "/user/project");

  @override
  Future<List<UserProject>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => (jsonDecodeData as List)
          .map((data) => UserProject.fromJson(data))
          .toList(),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<List<UserProject>?> getProjectInfo() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}

class UserWarningApi extends PCubeApi {
  UserWarningApi() : super(endPoint: "/user/warning");

  @override
  Future<UserWarning?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => UserWarning.fromJson(jsonDecodeData),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<UserWarning?> getWarningInfo() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}
