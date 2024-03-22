import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';

import '../models/rent.dart';
import 'package:http/http.dart' as http;

class RentListApi {
  Future<List<Rent>> get(int id) async {
    var response = await PCubeApi("/rent").get();
    return ApiUtil.instance.convertToList<Rent>(Rent.fromJson, response);
  }
}
