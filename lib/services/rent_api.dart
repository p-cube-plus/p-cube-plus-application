import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';

import '../models/rent.dart';

class RentListApi {
  Future<List<Rent>> get(int id) async {
    var response = await PCubeApi("/rent").get();
    return JsonUtil.instance.convertToList<Rent>(Rent.fromJson, response.body);
  }
}
