import 'package:domain/models/notification/notification_data.dart';
import 'package:domain/services/notification_service.dart';

import '../../utils/json_util.dart';
import '../http/pcube_api.dart';
import '../models/notification/notification_dto.dart';

class NotificationServiceImpl implements NotificationService {
  @override
  Future<List<NotificationData>> getNotificationList() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil()
        .convertToList<NotificationDTO>(NotificationDTO.fromJson, response.body)
        .map((dto) => dto.toDomain())
        .toList();
  }
}
