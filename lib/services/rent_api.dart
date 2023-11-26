import 'package:p_cube_plus_application/services/base/pcube_api.dart';

import '../models/rent.dart';

class RentListApi extends PCubeApi {
  RentListApi({int? id}) : super(endPoint: "/rent/${id?.toString() ?? "list"}");

  @override
  Future<List<Rent>?> get({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    return await super.get(
      successReturnFunction: (jsonDecodeData) =>
          (jsonDecodeData as List).map((data) => Rent.fromJson(data)).toList(),
      queryParams: queryParams,
    );
  }
}
