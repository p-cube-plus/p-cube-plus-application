import 'package:data/models/remote/notification/notification_dto.dart';
import 'package:data/models/remote/user/user_profile_dto.dart';
import 'package:data/models/remote/user/user_project_dto.dart';
import 'package:data/models/remote/user/user_warning_dto.dart';
import 'package:data/source/remote/user_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class UserServiceImpl implements UserService {
  @override
  Future<List<NotificationDTO>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil().convertToList<NotificationDTO>(
        NotificationDTO.fromJson, response.body);
  }

  @override
  Future<UserProfileDTO> getUserProfile() async {
    var response = await PCubeApi("/user/profile").get();
    return JsonUtil()
        .convertTo<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  @override
  Future<List<UserProjectDTO>> getUserProject() async {
    var response = await PCubeApi("/user/project").get();
    return JsonUtil()
        .convertToList<UserProjectDTO>(UserProjectDTO.fromJson, response.body);
  }

  @override
  Future<UserWarningDTO> get() async {
    var response = await PCubeApi("/user/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body);
  }
}
