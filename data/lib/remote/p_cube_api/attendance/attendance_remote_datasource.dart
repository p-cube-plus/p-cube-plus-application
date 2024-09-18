import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/attendance/response/attendance_check_response_dto.dart';
import 'package:data/remote/p_cube_api/attendance/response/attendance_detail_response_dto.dart';
import 'package:data/utils/json_util.dart';

import 'body/update_attendance_body_dto.dart';

class AttendanceRemoteDatasource {
  Future<AttendanceDetailResponseDTO> getAttendanceDetail() async {
    var response = await PCubeApi().get("/attendance/detail");

    return JsonUtil().convertTo<AttendanceDetailResponseDTO>(
      AttendanceDetailResponseDTO.fromJson,
      response.body,
    );
  }

  Future<AttendanceCheckResponseDTO> getAttendanceHistory(
    int attendanceId, {
    int prevAttendanceCount = 4,
  }) async {
    var response = await PCubeApi().get(
      "/attendance/$attendanceId",
      queryParameters: {
        "prev_attendance_count": "$prevAttendanceCount",
      },
    );

    return JsonUtil().convertTo<AttendanceCheckResponseDTO>(
      AttendanceCheckResponseDTO.fromJson,
      response.body,
    );
  }

  Future<void> updateAttendance(
    int attendanceId,
    UpdateAttendanceBodyDTO body,
  ) async {
    await PCubeApi().put(
      "/attendance/$attendanceId",
      body: JsonUtil().mapToJson(body.toMap()),
    );
  }
}
