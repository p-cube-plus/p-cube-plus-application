import 'package:p_cube_plus_application/models/notification_node.dart';
import 'base/pcube_api.dart';

class NoticeListApi extends PCubeApi {
  NoticeListApi({int? id}) : super(endPoint: "/user/notification");

  @override
  Future<List<NotificationNode>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers}) async {
    return await super.get(
        decodeFunction: (jsonDecodeData) => (jsonDecodeData as List)
            .map((data) => NotificationNode.fromJson(data))
            .toList());
  }
}
