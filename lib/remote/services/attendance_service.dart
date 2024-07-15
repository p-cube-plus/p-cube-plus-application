import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/models/attendance_dto.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class AttendanceService {
  Future<AttendanceCheckDTO> getAttendanceHistory(int id) async {
    var response =
        await PCubeApi("/attendance/$id?=prev_attendance_count=4").get();

    return JsonUtil().convertTo<AttendanceCheckDTO>(
        AttendanceCheckDTO.fromJson, response.body);
  }
}
