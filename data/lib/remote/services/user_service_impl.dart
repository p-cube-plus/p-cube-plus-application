import 'package:domain/models/notification/notification_data.dart';
import 'package:domain/models/user/user_profile_data.dart';
import 'package:domain/models/user/user_project_data.dart';
import 'package:domain/models/user/user_warning_data.dart';
import 'package:domain/services/user_service.dart';

import '../../utils/json_util.dart';
import '../http/pcube_api.dart';
import '../models/notification/notification_dto.dart';
import '../models/user/user_profile_dto.dart';
import '../models/user/user_project_dto.dart';
import '../models/user/user_warning_dto.dart';

class UserServiceImpl implements UserService {
  @override
  Future<List<NotificationData>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil()
        .convertToList<NotificationDTO>(NotificationDTO.fromJson, response.body)
        .map((dto) => dto.toDomain())
        .toList();
  }

  @override
  Future<UserProfileData> getUserProfile() async {
    var response = await PCubeApi("/user/profile").get();
    return JsonUtil()
        .convertTo<UserProfileDTO>(UserProfileDTO.fromJson, response.body)
        .toDomain();
  }

  @override
  Future<List<UserProjectData>> getUserProject() async {
    var response = await PCubeApi("/user/project").get();
    return JsonUtil()
        .convertToList<UserProjectDTO>(UserProjectDTO.fromJson, response.body)
        .map((dto) => dto.toDomain())
        .toList();
  }

  @override
  Future<UserWarningData> getUserWarning() async {
    var response = await PCubeApi("/user/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body)
        .toDomain();
  }

  @override
  Future<UserWarningData> getCurrentUserWarning() async {
    var response = await PCubeApi("/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body)
        .toDomain();
  }
}
