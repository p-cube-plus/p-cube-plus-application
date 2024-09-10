import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/user/models/user_warning_dto.dart';
import 'package:data/utils/json_util.dart';

class WarningRemoteDatasource {
  Future<UserWarningDTO> getUserWarning() async {
    var response = await PCubeApi("/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body);
  }
}
