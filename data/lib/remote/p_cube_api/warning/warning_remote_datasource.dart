import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/user/models/user_warning_dto.dart';
import 'package:data/utils/json_util.dart';

class WarningRemoteDatasource {
  Future<UserWarningDTO> getUserWarning() async {
    var response = await PCubeApi().get("/warning");
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body);
  }
}
