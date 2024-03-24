import 'package:p_cube_plus_application/utilities/json_util.dart';
import '../models/rent.dart';
import 'base/pcube_api.dart';

class ProductListApi {
  Future<List<Rent>> get() async {
    var response = await PCubeApi("/product/list").get();
    return JsonUtil.instance.convertToList<Rent>(Rent.fromJson, response.body);
  }
}
