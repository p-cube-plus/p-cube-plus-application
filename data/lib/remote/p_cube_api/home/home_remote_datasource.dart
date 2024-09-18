import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/utils/json_util.dart';

import 'response/home_attendance_response_dto.dart';
import 'response/home_calendar_response_dto.dart';

class HomeRemoteDatasource {
  Future<List<HomeAttendanceResponseDTO>> getHomeAttendance() async {
    var response = await PCubeApi().get("/home/attendance");
    return JsonUtil().convertToList<HomeAttendanceResponseDTO>(
        HomeAttendanceResponseDTO.fromJson, response.body);
  }

  Future<HomeCalendarResponseDTO> getHomeSchedule() async {
    var response = await PCubeApi().get("/home/schedule");
    return JsonUtil().convertTo<HomeCalendarResponseDTO>(
        HomeCalendarResponseDTO.fromJson, response.body);
  }
}
