import 'dart:convert';

import '../models/notification_node.dart';
import '../models/user.dart';
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
  Future<User> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => User.fromJson(jsonDecode(body)),
    );
  }
}
