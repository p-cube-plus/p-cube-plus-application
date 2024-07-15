import 'package:p_cube_plus_application/remote/models/warning_dto.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class UserWarningService {
  Future<WarningDTO> getCurrentUserWarning() async {
    var response = await PCubeApi("/warning").get();
    return JsonUtil().convertTo<WarningDTO>(WarningDTO.fromJson, response.body);
  }
}
