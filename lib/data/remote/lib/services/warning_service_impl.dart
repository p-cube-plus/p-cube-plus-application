import 'package:data/models/remote/user/user_warning_dto.dart';
import 'package:data/source/remote/user_warning_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class UserWarningServiceImpl implements UserWarningService {
  @override
  Future<UserWarningDTO> getCurrentUserWarning() async {
    var response = await PCubeApi("/warning").get();
    return JsonUtil()
        .convertTo<UserWarningDTO>(UserWarningDTO.fromJson, response.body);
  }
}
