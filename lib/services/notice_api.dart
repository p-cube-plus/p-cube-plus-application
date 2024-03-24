import 'package:p_cube_plus_application/models/notification_node.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';
import 'base/pcube_api.dart';

class NoticeListApi {
  Future<List<NotificationNode>> get() async {
    var response = await PCubeApi("/user/notification").get();
    return JsonUtil.instance.convertToList<NotificationNode>(
        NotificationNode.fromJson, response.body);
  }
}
