import 'dart:convert';

import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';

import '../models/notification_node.dart';
import '../models/user/user_profile.dart';
import 'base/pcube_api.dart';

class NoticeListApi extends PCubeApi {
  NoticeListApi() : super(endPoint: "/user/notification");

  @override
  Future<List<NotificationNode>> get(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (body) => (jsonDecode(body) as List)
            .map<NotificationNode>((data) => NotificationNode.fromJson(data))
            .toList(),
      );
}

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  @override
  Future<UserProfile> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => UserProfile.fromJson(jsonDecode(body)),
    );
  }
}

class UserProjectApi extends PCubeApi {
  UserProjectApi() : super(endPoint: "/user/project");

  @override
  Future<List<UserProject>> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => (jsonDecode(body) as List)
          .map<UserProject>((data) => UserProject.fromJson(data))
          .toList(),
    );
  }
}

class UserWarningApi extends PCubeApi {
  UserWarningApi() : super(endPoint: "/user/warning");

  @override
  Future<UserWarning> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => UserWarning.fromJson(jsonDecode(body)),
    );
  }
}
