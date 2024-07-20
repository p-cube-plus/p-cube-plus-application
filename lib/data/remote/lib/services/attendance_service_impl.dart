import 'package:data/models/remote/attendance/attendance_check_dto.dart';
import 'package:data/source/remote/attendance_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class AttendanceServiceImpl implements AttendanceService {
  @override
  Future<AttendanceCheckDTO> getAttendanceHistory(int id) async {
    var response =
        await PCubeApi("/attendance/$id?=prev_attendance_count=4").get();

    return JsonUtil().convertTo<AttendanceCheckDTO>(
        AttendanceCheckDTO.fromJson, response.body);
  }
}
