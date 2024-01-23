import 'package:p_cube_plus_application/services/base/pcube_api.dart';

import '../models/rent.dart';
import 'package:http/http.dart' as http;

class RentListApi extends PCubeApi {
  RentListApi({int? id}) : super(endPoint: "/rent/${id?.toString() ?? "list"}");

  @override
  Future<List<Rent>?> get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    return await super.get(
      successReturnFunction: (response) =>
          (response.body as List).map((data) => Rent.fromJson(data)).toList(),
      queryParams: queryParams,
    );
  }
}
