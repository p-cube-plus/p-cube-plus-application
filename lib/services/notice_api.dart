import 'package:p_cube_plus_application/models/notification_node.dart';
import 'package:http/http.dart' as http;
import 'base/pcube_api.dart';

class NoticeListApi extends PCubeApi {
  NoticeListApi({int? id}) : super(endPoint: "/user/notification");

  @override
  Future<List<NotificationNode>?> get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    return await super.get(
      successReturnFunction: (response) => (response.body as List)
          .map((data) => NotificationNode.fromJson(data))
          .toList(),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}
