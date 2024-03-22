import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';

import '../models/notification_node.dart';
import '../models/user/user_profile.dart';
import 'base/pcube_api.dart';

class NoticeListApi {
  Future<List<NotificationNode>> get() async {
    var response = await PCubeApi("/user/notification").get();
    return ApiUtil.instance.convertToList<NotificationNode>(NotificationNode.fromJson, response);
  }
}

class UserProfileApi {
  Future<UserProfile> get() async {
    var response = await PCubeApi("/user/profile").get();
    return ApiUtil.instance.convertTo<UserProfile>(UserProfile.fromJson, response);
  }
}

class UserProjectApi {
  Future<List<UserProject>> get() async {
    var response = await PCubeApi("/user/project").get();
    return ApiUtil.instance.convertToList<UserProject>(UserProject.fromJson, response);
  }
}

class UserWarningApi {
  Future<UserWarning> get() async {
    var response = await PCubeApi("/user/warning").get();
    return ApiUtil.instance.convertTo<UserWarning>(UserWarning.fromJson, response);
  }
}
