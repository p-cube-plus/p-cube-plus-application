import 'package:domain/models/attendance/attendance_check_data.dart';
import 'package:domain/services/attendance_service.dart';

import '../../utils/json_util.dart';
import '../http/pcube_api.dart';
import '../models/attendance/attendance_check_dto.dart';

class AttendanceServiceImpl implements AttendanceService {
  @override
  Future<AttendanceCheckData> getAttendanceHistory(int id) async {
    var response =
        await PCubeApi("/attendance/$id?=prev_attendance_count=4").get();

    return JsonUtil()
        .convertTo<AttendanceCheckDTO>(
            AttendanceCheckDTO.fromJson, response.body)
        .toDomain();
  }
}
