import 'package:data/models/remote/notification/notification_dto.dart';
import 'package:data/source/remote/notification_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class NotificationServiceImpl implements NotificationService {
  @override
  Future<List<NotificationDTO>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil().convertToList<NotificationDTO>(
        NotificationDTO.fromJson, response.body);
  }
}
