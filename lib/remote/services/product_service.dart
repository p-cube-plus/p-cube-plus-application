import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';
import '../models/rent_dto.dart';

class ProductService {
  Future<List<RentDTO>> getRentList() async {
    var response = await PCubeApi("/product/list").get();
    return JsonUtil().convertToList<RentDTO>(RentDTO.fromJson, response.body);
  }
}
