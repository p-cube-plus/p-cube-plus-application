import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';
import '../models/rent_dto.dart';

class RentService {
  Future<List<RentDTO>> getRentList(int id) async {
    var response = await PCubeApi("/rent").get();
    return JsonUtil().convertToList<RentDTO>(RentDTO.fromJson, response.body);
  }
}
