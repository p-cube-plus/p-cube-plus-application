import 'dart:convert';

import 'package:p_cube_plus_application/models/attendanceCheck.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';
import 'base/pcube_api.dart';

class AttendanceCheckApi {
  const AttendanceCheckApi(this.id);
  final int id;
  Future<AttendanceCheck?> get() async {
    var response = await PCubeApi("/attendance/$id").get(queryParams: {
      "prev_attendance_count": "4",
    });

    if ((jsonDecode(response.body) as Map).containsKey("message")) return null;
    return JsonUtil.instance
        .convertTo<AttendanceCheck>(AttendanceCheck.fromJson, response.body);
  }
}
