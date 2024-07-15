import 'package:p_cube_plus_application/remote/models/user_profile_dto.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/models/notification_dto.dart';
import 'package:p_cube_plus_application/remote/models/user_project_dto.dart';
import 'package:p_cube_plus_application/remote/models/user_warning_dto.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class UserService {
  Future<List<NotificationDTO>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil().convertToList<NotificationDTO>(
        NotificationDTO.fromJson, response.body);
  }

  Future<UserProfileDTO> getUserProfile() async {
    var response = await PCubeApi("/user/profile").get();
    return JsonUtil()
        .convertTo<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  Future<List<UserProjectDTO>> getUserProject() async {
    var response = await PCubeApi("/user/project").get();
    return JsonUtil()
        .convertToList<UserProjectDTO>(UserProjectDTO.fromJson, response.body);
  }

  Future<UserWarningDTO> get() async {
    var response = await PCubeApi("/user/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body);
  }
}
