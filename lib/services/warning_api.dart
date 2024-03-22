import 'package:p_cube_plus_application/models/warning.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';

import 'base/pcube_api.dart';

class WarningApi {
  Future<Warning> get() async {
    var response = await PCubeApi("/warning").get();
    return ApiUtil.instance.convertTo<Warning>(Warning.fromJson, response);
  }
}
