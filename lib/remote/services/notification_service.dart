import 'package:p_cube_plus_application/remote/models/notification_dto.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class NotificationService {
  Future<List<NotificationDTO>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil().convertToList<NotificationDTO>(
        NotificationDTO.fromJson, response.body);
  }
}
